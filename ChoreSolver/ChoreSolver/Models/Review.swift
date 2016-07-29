//
//  Review.swift
//  ChoreSolver
//
//  Created by yao  on 7/28/16.
//  Copyright © 2016 yao . All rights reserved.
//

import Foundation
import Parse
class Review: PFObject {
    @NSManaged var customer: User
    @NSManaged var cleanPerson: User
//    @NSManaged var description: String
    @NSManaged var stars: NSNumber
    
    
}