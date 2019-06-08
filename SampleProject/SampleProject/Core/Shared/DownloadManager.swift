//
//  DownloadManager.swift
//  SampleProject
//
//  Created by Muneeb Ali on 08/06/2019.
//  Copyright © 2019 Muneeb. All rights reserved.
//

import Foundation
import AssetsLibrary
import CoreData
import UIKit


protocol DownloaderDelegate {
    func setProgress(num:Float)
}


final class DownloadManager: NSObject, URLSessionDownloadDelegate {
    
    //MARK: - Variables
    static let sharedInstace = DownloadManager()
    var delegate:DownloaderDelegate?
    var contentID: String?
    var contentTitle: String?
    var artistname: String?
    var songURL : URL?
    var imsgeURL: URL?
    var isDownloading = false
    var imageFile: String?
    var audioFile: String?
    var isDownload = true
    
    
    
    //MARK: - init Method
    override init( ){
    }
    
    
    //MARK: - Download Methods
    
    //To Download File
    func download(){
        isDownloading = true
        isDownload = false
        let backgroundSessionConfiguration = URLSessionConfiguration.background(withIdentifier: ("Song") )
        let defaultSession = Foundation.URLSession(configuration: backgroundSessionConfiguration, delegate: self, delegateQueue: OperationQueue.main)
        let downloadTask = defaultSession.downloadTask(with: songURL!)
        downloadTask.resume()
    }
    
    
    // Called once the download is complete
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        var audioPathURL: URL?
        
        let dataFromURL = NSData(contentsOf: location)
        
        if session.configuration.identifier == "Song" {
            audioPathURL = MAFileManager.createSubDirectory().appendingPathComponent(audioFile ?? "")
            dataFromURL?.write(to: audioPathURL!, atomically: true)
            isDownload = true
        }
        
        if isDownload {
            isDownloading = false
            Utility.showSucessWith(message: "\(contentTitle ?? "") Downloaded Successfully")
            
        } else {
            print("Failed saving")
            Utility.showSucessWith(message: "\(contentTitle ?? "") Downloaded Failed")
        }
        
    }
    
    
    //Track Downloading Progress
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        print("Downloaded \(bytesWritten) bytes --- Written \(totalBytesWritten) bytes --- Total \(totalBytesExpectedToWrite) bytes ")
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        delegate?.setProgress(num: progress)
    }
    
    
    // This will call when error occure
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?){
        if(error != nil){
            print("⛔️⛔️⛔️⛔️⛔️ Download completed with error: \(error!.localizedDescription) ⛔️⛔️⛔️⛔️⛔️");
            Utility.showErrorWith(message: "Error occurs while downloading song")
            isDownloading = false
        }
    }
    
}
