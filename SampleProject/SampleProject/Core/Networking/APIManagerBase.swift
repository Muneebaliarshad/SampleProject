//
//  APIManagerBase.swift
//  SampleProject
//
//  Created by Muneeb Ali on 08/06/2019.
//  Copyright © 2019 Muneeb. All rights reserved.
//

import UIKit
import Alamofire

class APIManagerBase: NSObject{
    
    var alamoFireManager : SessionManager!
    let baseURL = Constants.BaseURL
    let defaultRequestHeader = ["Content-Type": "application/json"]
    let defaultError = NSError(domain: "ACError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Request Failed."])
    
    
    override init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        configuration.timeoutIntervalForResource = 15
        alamoFireManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    
    //MARK:- Header Creation
    func getErrorFromResponseData(data: Data) -> NSError? {
        do{
            let result = try JSONSerialization.jsonObject(with: data,options: JSONSerialization.ReadingOptions.mutableContainers) as? Array<Dictionary<String,AnyObject>>
            if let message = result?[0]["message"] as? String{
                let error = NSError(domain: "GCError", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
                return error;
            }
        }catch{
            NSLog("Error: \(error)")
        }
        
        return nil
    }
    
    
    //MARK:- URL Creation
    func URLforRoute(route: String, params: Parameters) -> NSURL? {
        
        if let components: NSURLComponents  = NSURLComponents(string: (baseURL + route)){
            var queryItems = [NSURLQueryItem]()
            for(key,value) in params{
                queryItems.append(NSURLQueryItem(name:key,value: value as? String))
            }
            components.queryItems = queryItems as [URLQueryItem]?
            
            return components.url as NSURL?
        }
        return nil;
    }
    
    
    func POSTURLforRoute(route:String) -> URL?{
        
        if let components: NSURLComponents = NSURLComponents(string: (baseURL + route)){
            return components.url! as URL
        }
        return nil
    }
    
    // Pass paramaters same as post request. (But in string)
    func GETURLfor(route:String, parameters: Parameters) -> URL?{
        var queryParameters = ""
        for key in parameters.keys {
            if queryParameters.isEmpty {
                queryParameters =  "?\(key)=\((String(describing: (parameters[key]!))).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)"
            } else {
                queryParameters +=  "&\(key)=\((String(describing: (parameters[key]!))).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)"
            }
            queryParameters =  queryParameters.trimmingCharacters(in: .whitespaces)
            
        }
        if let components: NSURLComponents = NSURLComponents(string: (baseURL + route + queryParameters)){
            return components.url! as URL
        }
        return nil
    }
    
    //MARK:- Header Creation
    func serverRequestWith(route: URL,
                           parameters: Parameters,
                           requestType:HTTPMethod,
                           success:@escaping DefaultArrayResultAPISuccessClosure,
                           failure:@escaping DefaultAPIFailureClosure) {
        
        alamoFireManager.request(route, method: requestType, parameters: nil, encoding: JSONEncoding.default, headers: defaultRequestHeader).responseJSON{
            response in
            guard response.result.error == nil else{
                
                //FIXME: delete this below function call before creating distribution build
                self.showRequestDetailForFailure(responseObject: response)
                failure(response.result.error! as NSError)
                return;
            }
            if response.result.value != nil {
                //FIXME: delete this below function call before creating distribution build
                self.showRequestDetailForSuccess(responseObject: response)
                if let jsonResponse = response.result.value as? Dictionary<String, AnyObject>{
                    
                    success(jsonResponse)
                } else {
                    success(Dictionary<String, AnyObject>())
                }
            }
        }
    }
    
    
    func postRequestWithMultipart(route: URL,image: UIImage,fileName:String,
                                  success:@escaping DefaultArrayResultAPISuccessClosure,
                                  failure:@escaping DefaultAPIFailureClosure){
        
        let URLSTR = try! URLRequest(url: route.absoluteString, method: HTTPMethod.post, headers: defaultRequestHeader)
        
        
        let imageData = image.pngData()
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(fileName.data(using: String.Encoding.utf8)!, withName: "filnm")
            multipartFormData.append(imageData!, withName: "file", fileName: fileName, mimeType: "image/png")
        }, with: URLSTR, encodingCompletion: {result in
            
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    
                    guard response.result.error == nil else{
                        //FIXME: delete this below function call before creating distribution build
                        self.showRequestDetailForFailure(responseObject: response)
                        failure(response.result.error! as NSError)
                        return;
                    }
                    
                    if let _ = response.result.value {
                        //FIXME: delete this below function call before creating distribution build
                        self.showRequestDetailForSuccess(responseObject: response)
                        if let jsonResponse = response.result.value as? Dictionary<String, AnyObject>{
                            success(jsonResponse)
                        } else {
                            success(Dictionary<String, AnyObject>())
                        }
                    }
                }
            case .failure(let encodingError):
                failure(encodingError as NSError)
            }
        })
    }
    
    
    
    
    fileprivate func multipartFormData(parameters: Parameters) {
        let formData: MultipartFormData = MultipartFormData()
        if let params:[String:AnyObject] = parameters as [String : AnyObject]? {
            for (key , value) in params {
                
                if let data:Data = value as? Data {
                    
                    formData.append(data, withName: "profile_picture", fileName: "image.png", mimeType: "image/png")
                } else {
                    formData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                }
            }
            
            print("\(formData)")
        }
    }
    
    
    // MARK:- Print Result
    func showErrorMessage(error: Error){
        print("")
        switch (error as NSError).code {
        case -1001:
            print("Time Out")
        case -1009:
            print("No Network")
        case 4:// Api Call Error
            print("Bad Request")
        case -1005:
            print("No Network")
        default:
            print((error as NSError).localizedDescription)
        }
    }
    
    
    func showRequestDetailForSuccess(responseObject response : DataResponse<Any>) {
        
        #if DEBUG
        print("\n\n\n📲📲📲📲📲 ------- Success Response Start ------- 📲📲📲📲📲\n")
        print(""+(response.request?.url?.absoluteString ?? ""))
        print("\n=========   allHTTPHeaderFields   ========== \n")
        print("%@",response.request!.allHTTPHeaderFields!)
        print("\n=========   Request Type   ========== \n")
        print("%@",response.request?.httpMethod?.description ?? "")
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
        print("\n📲📲📲📲📲 ------- Success Response End ------- 📲📲📲📲📲\n\n\n")
        
        #endif
    }
    
    func showRequestDetailForFailure(responseObject response : DataResponse<Any>) {
        
        #if DEBUG
        print("\n\n\n📵📵📵📵📵 ------- Failure Response Start ------- 📵📵📵📵📵\n")
        print(""+(response.request?.url?.absoluteString ?? ""))
        print("\n=========   allHTTPHeaderFields   ========== \n")
        print("%@",response.request!.allHTTPHeaderFields!)
        print("\n=========   Request Type   ========== \n")
        print("%@",response.request?.httpMethod?.description ?? "")
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
        
        print("\n=========   Error  ========== \n" + (response.error.debugDescription ))
        print("\n📵📵📵📵📵 ------- Failure Response End ------- 📵📵📵📵📵\n\n\n")
        
        #endif
    }
    
    
    
}

public extension Data {
    var mimeType:String {
        get {
            var c = [UInt32](repeating: 0, count: 1)
            (self as NSData).getBytes(&c, length: 1)
            switch (c[0]) {
            case 0xFF:
                return "image/jpeg";
            case 0x89:
                return "image/png";
            case 0x47:
                return "image/gif";
            case 0x49, 0x4D:
                return "image/tiff";
            case 0x25:
                return "application/pdf";
            case 0xD0:
                return "application/vnd";
            case 0x46:
                return "text/plain";
            default:
                print("mimeType for \(c[0]) in available");
                return "application/octet-stream";
            }
        }
    }
}
