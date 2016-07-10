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
class CleanPerson: PFObject, PFSubclassing {
    
    @NSManaged var imageFile: PFFile?
    @NSManaged var user: PFUser?
    
    
    //MARK: PFSubclassing Protocol
    
    static func parseClassName() -> String {
        return "CleanPerson"
    }

    override init () {
        super.init()
    }
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
        }
    }
    
}