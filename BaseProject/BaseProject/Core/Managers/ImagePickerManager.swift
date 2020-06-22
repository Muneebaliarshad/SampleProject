//
//  ImagePickerManager.swift
//  BaseProject
//
//  Created by Muneeb Ali on 22/06/2020.
//  Copyright © 2020 Muneeb Ali. All rights reserved.
//

import UIKit
import AVFoundation


class ImagePickerManager: NSObject, UINavigationControllerDelegate {
    
    //MARK: - Variables
    var picker: UIImagePickerController?
    var alert: UIAlertController?
    var pickImageCallback : ((UIImage) -> ())?;
    
    
    //MARK: - Init Methods
    override init(){
        super.init()
    }
    
    
    //MARK: - Permission Methods
    func checkCameraPermission() -> (Bool,String) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied:
            return (false,"OpenSetting")
            
        case .restricted:
            return (false,"")
            
        case .authorized:
            return (true,"")
            
        case .notDetermined:
            return (false,"")
            
        default:
            return (false,"")
        }
    }
    
    
    func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { success in
            if success {
            } else {
            }
        }
    }
    
    
    func openAppSetting() {
        if let url = NSURL(string: UIApplication.openSettingsURLString) as URL? {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    
    //MARK: - Camera And Galler Methods
    func pickImage(_ callback: @escaping ((UIImage) -> ())) {
        pickImageCallback = callback
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) {
            UIAlertAction in
            self.openCamera()
        }
        
        let gallaryAction = UIAlertAction(title: "Gallary", style: .default){
            UIAlertAction in
            self.openGallery()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            UIAlertAction in
        }
        
        picker = UIImagePickerController()
        picker?.delegate = self
        
        alert = UIAlertController(title: "Select Option", message: nil, preferredStyle: .actionSheet)
        alert?.addAction(cameraAction)
        alert?.addAction(gallaryAction)
        alert?.addAction(cancelAction)
        
        Utility.getTopViewController().present(alert!, animated: true, completion: nil)
    }
    
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker?.sourceType = .camera
            Utility.getTopViewController().present(picker!, animated: true, completion: nil)
        } else {
            Utility.showAlert(isSucess: false, "Warning", "You don't have camera")
        }
        
    }
    
    
    func openGallery() {
        picker?.sourceType = .photoLibrary
        Utility.getTopViewController().present(picker!, animated: true, completion: nil)
    }
    
}


//MARK: - UIImagePickerControllerDelegate Methods
extension ImagePickerManager: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        DispatchQueue.main.async {
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            self.picker = nil
            self.alert = nil
            self.pickImageCallback?(image)
        }
    }
    
}

/*
 // USGAE:-
 //Use below code in your controller like this :
 
 ImagePickerManager().pickImage(self){ image in
 //here is the image
 }
 
 //NOTE:-
 //Don't forget to add the following keys/pairs in your info.plist
 
 <key>NSCameraUsageDescription</key>
 <string>This app requires access to the camera.</string>
 <key>NSPhotoLibraryUsageDescription</key>
 <string>This app requires access to the photo library.</string>
 */
