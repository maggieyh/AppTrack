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
    static let ParseRequestAgree = "Agree"
    
    static func initRequestInfo(customer: PFUser, cleanPerson: PFUser) {
        //Check if the Request object already set between these two user
        let requestQuery = PFQuery(className: ParseRequestClass)
        requestQuery.whereKey(ParseRequestCustomer , equalTo: customer)
        requestQuery.whereKey(ParseRequestCleanPerson, equalTo: cleanPerson)
        requestQuery.findObjectsInBackgroundWithBlock { (result: [PFObject]?, error: NSError?) in
            if result!.count == 0 {
                print("aa")
                //Set up new Request object
                let requestObject = PFObject(className: ParseRequestClass)
                requestObject[ParseRequestCustomer] = customer
                requestObject[ParseRequestCleanPerson] = cleanPerson
                requestObject[ParseRequestAgree] = NSNumber(bool: false)
                requestObject.saveInBackgroundWithBlock(nil)
            }
        }
        
        
    }
    
    
}

