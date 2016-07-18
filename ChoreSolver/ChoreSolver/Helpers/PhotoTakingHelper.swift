//
//  PhotoTakingHelper.swift
//  Makestagram
//
//  Created by yao  on 6/27/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit

typealias PhotoTakingHelperCallback = UIImage? -> Void
class PhotoTakingHelper: NSObject {
    
    //View controller on which AlertViewController and UIImagePickerController are presented
    weak var viewController: UIViewController!
    var callback: PhotoTakingHelperCallback
    var imagePickerController: UIImagePickerController?
    
    init(viewController: UIViewController, callback: PhotoTakingHelperCallback) {
        self.viewController = viewController
        self.callback = callback
        
        super.init()
        
        showPhotoSourceSelection()
    }
    
    func showPhotoSourceSelection() {
        //Allow user to choose between photo library and camera
        let alertController = UIAlertController(title: nil, message: "Where to get your picture", preferredStyle: .ActionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let photoLibraryAction = UIAlertAction(title: "Photo from Library", style: .Default ) { (action) in self.showImagePickerController(.PhotoLibrary) }
        
        
        alertController.addAction(photoLibraryAction)
        
        //only show camerea option if rear camera is available
        if(UIImagePickerController.isCameraDeviceAvailable(.Rear)) {
            let cameraAction = UIAlertAction(title: "Phto from Camera", style: .Default ) {
                (action) in self.showImagePickerController(.Camera)
            }
            
            alertController.addAction(cameraAction)
        }
        
        
        
        viewController.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func showImagePickerController(sourceType: UIImagePickerControllerSourceType) {
        imagePickerController = UIImagePickerController()
        //In the first line, this method creates a UIImagePickerController. In the second line, we set the sourceType of that controller. Depending on the sourceType the UIImagePickerController will activate the camera and display a photo taking overlay - or will show the user's photo library
        imagePickerController!.sourceType = sourceType
        imagePickerController!.delegate = self
        
        self.viewController.presentViewController(imagePickerController!, animated: true, completion: nil)
    }
}

extension PhotoTakingHelper: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        viewController.dismissViewControllerAnimated(false, completion: nil)
        
        callback(image)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
}




