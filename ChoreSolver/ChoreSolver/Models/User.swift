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
    
    @NSManaged var county: NSString?
    @NSManaged var introduction: NSString?
    @NSManaged var hourRate: NSString?
    
    
    override init() {
        super.init()
        
    }
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
        }
        PFUser.parseClassName()
    }
    
    
    
}