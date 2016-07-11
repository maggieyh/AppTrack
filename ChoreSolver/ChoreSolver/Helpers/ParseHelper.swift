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
        //another snippet to check if the Request object already set between these two user
        
        //Set up new Request object
        let requestObject = PFObject(className: ParseRequestClass)
        requestObject[ParseRequestCustomer] = customer
        requestObject[ParseRequestCleanPerson] = cleanPerson
        requestObject.saveInBackgroundWithBlock(nil)
    }
}
