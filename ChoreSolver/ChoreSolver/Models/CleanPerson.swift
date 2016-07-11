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
    
    @NSManaged var imageFile: PFFile?
    @NSManaged var hourRate: NSNumber?
    @NSManaged var instroduction: NSString?
    @NSManaged var phoneNumber: NSString?
    
    
    
}