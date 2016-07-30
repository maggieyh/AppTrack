//
//  Review.swift
//  ChoreSolver
//
//  Created by yao  on 7/28/16.
//  Copyright © 2016 yao . All rights reserved.
//

import Foundation
import Parse
class Review: PFObject, PFSubclassing {
    @NSManaged var customer: User
    @NSManaged var cleanPerson: User
    @NSManaged var comment: NSString
    @NSManaged var stars: NSNumber
    
    static func parseClassName() -> String {
        return "Review"
    }
    
    override init() {
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