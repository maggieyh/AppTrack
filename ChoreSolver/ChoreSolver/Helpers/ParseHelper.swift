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
    static let ParseUserType = "userType"
    static let ParseUserCounty = "county"
    
    static let ParseRequestClass = "Request"
    static let ParseRequestCustomer = "customer"
    static let ParseRequestCleanPerson = "cleanPerson"
    static let ParseRequestAgree = "agree"
    
    static func initRequestInfo(customer: PFUser, cleanPerson: PFUser, block: PFBooleanResultBlock ) {
        //Check if the Request object already set between these two user   ????
//        let requestQuery = PFQuery(className: ParseRequestClass)
//        requestQuery.whereKey(ParseRequestCustomer , equalTo: customer)
//        requestQuery.whereKey(ParseRequestCleanPerson, equalTo: cleanPerson)
//        requestQuery.findObjectsInBackgroundWithBlock { (result: [PFObject]?, error: NSError?) in
//            if result!.count == 0 {
                //Set up new Request object
                let requestObject = PFObject(className: ParseRequestClass)
                requestObject[ParseRequestCustomer] = customer
                requestObject[ParseRequestCleanPerson] = cleanPerson
                requestObject[ParseRequestAgree] = NSNumber(bool: false)
                requestObject.saveInBackgroundWithBlock(block)
//            }
//        }
        
        
    }
    
    static func searchResultViewRequestForCleanPerson(county: String, completionBlock: PFQueryArrayResultBlock) {
        let cleanPersonQuery : PFQuery = PFUser.query()!
        cleanPersonQuery.whereKey(ParseUserType, equalTo: "CleanPerson")
        //   cleanPersonQuery.whereKey("county", equalTo: self.selectedCounty!)
        cleanPersonQuery.whereKey(ParseUserCounty, equalTo: county)
        cleanPersonQuery.findObjectsInBackgroundWithBlock(completionBlock)
    }
   
    
    static func fetchParticularRequest(customer: PFUser, cleanPerson: PFUser, completionBlock: PFQueryArrayResultBlock ) {
        let requestQuery = PFQuery(className: ParseRequestClass)
        requestQuery.whereKey(ParseRequestCleanPerson, equalTo: cleanPerson)
        requestQuery.whereKey(ParseRequestCustomer, equalTo: customer)
        requestQuery.findObjectsInBackgroundWithBlock(completionBlock)            
//        requestQuery.getFirstObjectInBackgroundWithBlock(completionBlock)
    }
    
}

