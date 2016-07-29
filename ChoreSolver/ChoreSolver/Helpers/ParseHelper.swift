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
    static let ParseRequestChecked = "checked"
    
    static let ParseReviewClass = "Review"
    static let ParseReviewCustomer = "customer"
    static let ParseReviewCleanPerson = "cleanPerson"
    static let ParseReviewStar = "stars"
    static let ParseReviewDescription = "description"
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
                requestObject[ParseRequestChecked] = NSNumber(bool: false)
                requestObject.saveInBackgroundWithBlock(block)
//            }
//        }
        
        
    }
    
    static func initReview(stars: NSNumber, description: String, customer: PFUser, cleanPerson: PFUser) {
        let reviewObject = PFObject(className: ParseReviewClass)
        reviewObject[ParseReviewCustomer] = customer
        reviewObject[ParseReviewCleanPerson] = cleanPerson
        reviewObject[ParseReviewDescription] = description
        reviewObject[ParseReviewStar] = stars
        reviewObject.saveInBackground()
    }
    
    static func searchResultViewRequestForCleanPerson(range: Range<Int>, county: String, completionBlock: PFQueryArrayResultBlock) {
        let cleanPersonQuery : PFQuery = PFUser.query()!
        cleanPersonQuery.whereKey(ParseUserType, equalTo: "CleanPerson")
        //   cleanPersonQuery.whereKey("county", equalTo: self.selectedCounty!)
        cleanPersonQuery.whereKey(ParseUserCounty, equalTo: county)
        
        cleanPersonQuery.skip = range.startIndex
        cleanPersonQuery.limit = range.endIndex - range.startIndex
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

