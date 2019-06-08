//
//  APIClientHandler.swift
//  BaseProject
//
//  Created by Muneeb Ali on 29/05/2018.
//  Copyright © 2018 Muneeb Ali. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireNetworkActivityIndicator
import Realm
import RealmSwift


typealias APIClientCompletionBlock = (_ response: HTTPURLResponse?, _ result: AnyObject?, _ error: NSError?) -> Void

typealias APIClientCompletionHandler = (_ response: HTTPURLResponse?, _ resultData: AnyObject?, _ error: NSError?, _ isCancelled: Bool, _ callStatus: Bool, _ resultCode: String, _ resultDesc: String?) -> Void


enum APIClientHandlerErrorCode: Int {
    case general = 30001
    case noNetwork = 30002
    case timeOut = 30003
}

let kAPIClientHandlerErrorDomain = "com.es.backcell.webserviceerror"



class APIClientHandler: SessionManager {
    
    // MARK: - Properties methods
    fileprivate var serviceURL: URL?
    
    
    // MARK: - init & deinit methods
    
    init(baseURL: URL,
         configuration: URLSessionConfiguration = URLSessionConfiguration.default,
         delegate: SessionDelegate = SessionDelegate(),
         serverTrustPolicyManager: ServerTrustPolicyManager? = nil){
        
        super.init(configuration: configuration, delegate: delegate, serverTrustPolicyManager: serverTrustPolicyManager)
        
        var aURL = baseURL
        
        // Ensure terminal slash for baseURL path, so that NSURL relativeToURL works as expected
        
        if aURL.path.count > 0 && !aURL.absoluteString.hasSuffix("/") {
            aURL = baseURL.appendingPathComponent("")
        }
        
        serviceURL = baseURL
        NetworkActivityIndicatorManager.shared.isEnabled = true
    }
    
    // MARK: - Public methods
    
    func serverRequest(_ methodName: String,
                       parameters: [String : AnyObject]? ,
                       isPostRequest: Bool,
                       headers: [String : String]?,
                       completionBlock: @escaping APIClientCompletionBlock) -> Request {
        
        let url = URL(string: methodName, relativeTo: serviceURL)
        
        let HTTPCallMethod : HTTPMethod
        if !isPostRequest {
            HTTPCallMethod = HTTPMethod.get
        } else {
            HTTPCallMethod = HTTPMethod.post
        }
        
        let request = self.request(url!, method: HTTPCallMethod , parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<600)
            .responseJSON { response in
                
                switch response.result {
                    
                case .success:
                    //FIXME: delete this below function call before creating distribution build
                    self.showRequestDetailForSuccess(responseObject: response)
                    completionBlock(response.response, response.result.value as AnyObject?, nil)
                    break
                    
                case .failure(let error):
                    //FIXME: delete this below function call before creating distribution build
                    self.showRequestDetailForFailure(responseObject: response)
                    completionBlock(response.response, nil, error as NSError?)
                    break
                }
        }
        
        return request
    }
    
    func sendRequest(_ methodName: String,
                     parameters: [String : AnyObject]?,
                     isPostRequest: Bool,
                     headers: [String : String]?,
                     completionBlock: @escaping APIClientCompletionHandler) -> Request {
        
        let request = self.serverRequest(methodName, parameters: parameters, isPostRequest: isPostRequest, headers: headers) { (response, result, error) in
            
            var resultCode: String = "9999"
            
            if error != nil {
                var isCancelled = false
                var apiError = error
                
                if error?.code == NSURLErrorCancelled {
                    isCancelled = true
                }
                
                if error?.code == NSURLErrorNotConnectedToInternet {
                    let userInfo : [AnyHashable: Any] = [NSLocalizedDescriptionKey : "Message_NoInternet"]
                    apiError = self.createErrorWithErrorCode(APIClientHandlerErrorCode.noNetwork.rawValue, andErrorInfo: userInfo)
                    
                } else {
                    let userInfo : [AnyHashable: Any] = [NSLocalizedDescriptionKey : "Message_GenralError"]
                    apiError = self.createErrorWithErrorCode(APIClientHandlerErrorCode.timeOut.rawValue, andErrorInfo: userInfo)
                }
                
                completionBlock(response, nil, apiError, isCancelled, true, resultCode, "")
                
            } else {
                
                var sendError = false
                var callStatus = false
                var resultDesc = ""
                var resultError: NSError?
                var resultData: AnyObject?
                
                
                let responseHandler = ResponseHandler(value: result as Any)
                callStatus = responseHandler.callStatus
                
                if let messageDiscription = responseHandler.resultDesc {
                    resultDesc = messageDiscription
                }
                
                if let responseResultCode = responseHandler.resultCode {
                    resultCode = responseResultCode
                    
                    // Logout user and show error discription
                    //                        if responseResultCode == Constants.MBAPIStatusCode.sessionExpired.rawValue {
                    //                            //  BaseVC.logout()
                    //                            self.cancelAllRequests()
                    //
                    //                            return
                    //                        }
                }
                
                resultData = responseHandler.data
                
                if !callStatus {
                    
                    if resultData == nil {
                        resultData = true as AnyObject?
                    }
                    sendError = true
                }
                
                
                
                if sendError {
                    
                    resultError = self.createError(resultDesc)
                    completionBlock(response, nil, resultError, false, false, resultCode, resultDesc )
                    
                } else {
                    completionBlock(response, resultData, nil, false, true, resultCode, resultDesc )
                }
                //                (_ response: HTTPURLResponse?, _ result: AnyObject?, _ error: NSError?, _ isCancelled: Bool, _ status: Bool)
            }
        }
        
        return request
    }
    
    // MARK: - methods
    
    func createError(_ errorDescription: String) -> NSError {
        var description = "Message_GenralError"
        
        
        if errorDescription.count > 0 {
            description = errorDescription
        }
        
        let userInfo : [AnyHashable: Any] = [NSLocalizedDescriptionKey : description]
        
        return createErrorWithErrorCode(APIClientHandlerErrorCode.general.rawValue, andErrorInfo: userInfo)
    }
    
    func createErrorWithErrorCode(_ code: Int, andErrorInfo info: [AnyHashable: Any]?) -> NSError {
        return NSError(domain: kAPIClientHandlerErrorDomain, code: code, userInfo: info as? [String : Any])
    }
    
    func cancelAllRequests() {
        session.getAllTasks { tasks in
            
            for task in tasks {
                task.cancel()
            }
        }
    }
    
    func showRequestDetailForSuccess(responseObject response : DataResponse<Any>) {
        
        #if DEBUG
        print("\n\n\n✅✅✅✅ ------- Success Response Start ------- ✅✅✅✅\n")
        print(""+(response.request?.url?.absoluteString ?? ""))
        print("\n=========   allHTTPHeaderFields   ========== \n")
        print("%@",response.request!.allHTTPHeaderFields!)
        
        if let bodyData : Data = response.request?.httpBody {
            let bodyString = String(data: bodyData, encoding: String.Encoding.utf8)
            print("\n=========   Request httpBody   ========== \n" + (bodyString ?? ""))
        } else {
            print("\n=========   Request httpBody   ========== \n" + "Found Request Body Nil")
        }
        
        if let responseData : Data = response.data {
            let responseString = String(data: responseData, encoding: String.Encoding.utf8)
            print("\n=========   Response Body   ========== \n" + (responseString ?? ""))
        } else {
            print("\n=========   Response Body   ========== \n" + "Found Response Body Nil")
        }
        print("\n✅✅✅✅ ------- Success Response End ------- ✅✅✅✅\n\n\n")
        
        #endif
    }
    
    func showRequestDetailForFailure(responseObject response : DataResponse<Any>) {
        
        #if DEBUG
        print("\n\n\n❌❌❌❌ ------- Failure Response Start ------- ❌❌❌❌\n")
        print(""+(response.request?.url?.absoluteString ?? ""))
        print("\n=========   allHTTPHeaderFields   ========== \n")
        print("%@",response.request!.allHTTPHeaderFields!)
        
        if let bodyData : Data = response.request?.httpBody {
            let bodyString = String(data: bodyData, encoding: String.Encoding.utf8)
            print("\n=========   Request httpBody   ========== \n" + (bodyString ?? ""))
        } else {
            print("\n=========   Request httpBody   ========== \n" + "Found Request Body Nil")
        }
        
        if let responseData : Data = response.data {
            let responseString = String(data: responseData, encoding: String.Encoding.utf8)
            print("\n=========   Response Body   ========== \n" + (responseString ?? ""))
        } else {
            print("\n=========   Response Body   ========== \n" + "Found Response Body Nil")
        }
        print("\n❌❌❌❌ ------- Failure Response End ------- ❌❌❌❌\n\n\n")
        
        #endif
        
    }
    
    
    func GETURLfor(serviceName: String, parameters: Parameters) -> String {
        
        var queryParameters = ""
        for key in parameters.keys {
            if queryParameters.isEmpty {
                queryParameters =  "?\(key)=\((String(describing: (parameters[key]!))).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)"
            } else {
                queryParameters +=  "&\(key)=\((String(describing: (parameters[key]!))).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)"
            }
            queryParameters =  queryParameters.trimmingCharacters(in: .whitespaces)
            
        }
        return serviceName + queryParameters
    }
}
