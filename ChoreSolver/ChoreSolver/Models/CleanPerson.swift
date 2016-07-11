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
class CleanPerson: PFUser {
    
    @NSManaged var name: NSString?
    @NSManaged var imageFile: PFFile?
    @NSManaged var hourRate: NSNumber?
    @NSManaged var instroduction: NSString?
    @NSManaged var phoneNumber: NSString?
    
    var image: UIImage?
    
    func downloadImage() {

        if (image == nil) {
            imageFile?.getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) in
                if let data = data {
                    self.image = UIImage(data: data, scale: 1.0)
                }
            }
        }
    }
    
}