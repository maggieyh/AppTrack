//
//  CleanPerson.swift
//  ChoreSolver
//
//  Created by yao  on 7/10/16.
//  Copyright © 2016 yao . All rights reserved.
//



import Foundation
import Bond
import Parse
import ConvenienceKit
class User: PFUser {
    
    @NSManaged var userType: NSString?
    @NSManaged var phoneNumber: NSString?
    @NSManaged var imageFile: PFFile?
    @NSManaged var oneSignalID: NSString?
    @NSManaged var county: NSString?
    @NSManaged var introduction: NSString?
    @NSManaged var hourRate: NSString?
    
    static var imageCache: NSCacheSwift<String, UIImage>! //string is key, uiimage is value
    
    
    var image: Observable<UIImage?> = Observable(nil)

    override init() {
        super.init()
        
    }
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
            
            User.imageCache = NSCacheSwift<String, UIImage>()
        }
        
    }

    func downloadImage() {
        
        if let name = self.imageFile?.name {
             image.value = User.imageCache[name]
            
            if image.value == nil {
                
                imageFile?.getDataInBackgroundWithBlock({ (data: NSData?, error: NSError?) in
                    
                    if let data = data {
                        let image = UIImage(data: data, scale: 0.2)!
                        self.image.value = image
                        User.imageCache[self.imageFile!.name] = image
                    }
                    
                })
            }
        }
        
        
    
    }
    
    
}