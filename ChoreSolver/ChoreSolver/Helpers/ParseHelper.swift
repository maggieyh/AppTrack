//
//  ParseHelper.swift
//  ChoreSolver
//
//  Created by yao  on 7/10/16.
//  Copyright © 2016 yao . All rights reserved.
//

import Foundation
import Parse

class ParseHelper {
    static let ParseRequestClass = "Request"
    static let ParseRequestCustomer = "customer"
    static let ParseRequestCleanPerson = "cleanPerson"
    
    static func initRequestInfo(customer: PFUser, cleanPerson: PFUser) {
        let requestObject = PFObject(className: ParseRequestClass)
        requestObject[ParseRequestCustomer] = customer
        requestObject[ParseRequestCleanPerson] = cleanPerson
        requestObject.saveInBackgroundWithBlock(nil)
    }
}
