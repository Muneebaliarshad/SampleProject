//
//  FileManager.swift
//  SampleProject
//
//  Created by Muneeb Ali on 08/06/2019.
//  Copyright © 2019 Muneeb. All rights reserved.
//

import Foundation

struct FileManagerStrings {
    static let Audio = "Audio"
    static let Images = "Images"
    static let MP3 = ".mp3"
    static let WEBP = ".webp"
}


final class MAFileManager {
    
    static func createMainDirectory() -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let mainDirectory = documentsDirectory.appendingPathComponent(Constants.AppName)
        return mainDirectory
    }
    
    static func checkDirectoryExistence(_ directory: URL) {
        if !(FileManager.default.fileExists(atPath: directory.path)){
            do {
                try FileManager.default.createDirectory(atPath: directory.path, withIntermediateDirectories: true, attributes: nil)
            } catch let error as NSError {
                print("🗞🗞🗞🗞🗞  Error creating directory: \(error.localizedDescription) 🗞🗞🗞🗞🗞")
            }
        }
        print("🗂🗂🗂🗂🗂 Dcument Path: \(directory.path) 🗂🗂🗂🗂🗂")
    }
    
    
    
    static func isAlreadyExists(fileName:String) -> Bool {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath = documentsDirectory.appendingPathComponent(Constants.AppName).appendingPathComponent(FileManagerStrings.Audio).appendingPathComponent(fileName)
        
        if (FileManager.default.fileExists(atPath: filePath.path)){
            return true
        }else{
            return false
        }
        
    }
    
    static func createSubDirectory() -> URL {
        let audioDirectory = createMainDirectory().appendingPathComponent(FileManagerStrings.Audio)
        checkDirectoryExistence(audioDirectory)
        return audioDirectory
    }
    
    static func getSubDirectoryPath(fileName:String) -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath = documentsDirectory.appendingPathComponent(Constants.AppName).appendingPathComponent(FileManagerStrings.Audio).appendingPathComponent(fileName)
        return filePath
    }
    
    
    static func getAllFiles() -> [URL]{
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(Constants.AppName)
        var fileURLs = [URL]()
        do {
            fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            // process files
        } catch {
            print("🧨🧨🧨🧨🧨 Error while enumerating files \(documentsURL.path): \(error.localizedDescription) 🧨🧨🧨🧨🧨")
        }
        
        return fileURLs
    }
    
    
    static func deleteFileAt(fileName: String) {
        if isAlreadyExists(fileName: (fileName + FileManagerStrings.MP3)) {
            do {
                try FileManager.default.removeItem(at: getSubDirectoryPath(fileName: (fileName + FileManagerStrings.MP3)))
                
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("No data Found")
        }
    }
    
}
