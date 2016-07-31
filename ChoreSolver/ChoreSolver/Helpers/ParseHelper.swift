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
    static let ParseCleanPerson = "cleanPerson"
    static let ParseCustomer = "customer"
    static let ParseUserType = "userType"
    static let ParseUserCounty = "county"
    
    
    static let ParseRequestClass = "Request"
    static let ParseRequestAgree = "agree"
    static let ParseRequestChecked = "checked"
    
    static let ParseReviewClass = "Review"
    static let ParseReviewStar = "stars"
    static let ParseReviewDescription = "comment"
    static func initRequestInfo(customer: PFUser, cleanPerson: PFUser, block: PFBooleanResultBlock ) {
        //Check if the Request object already set between these two user   ????
//        let requestQuery = PFQuery(className: ParseRequestClass)
//        requestQuery.whereKey(ParseRequestCustomer , equalTo: customer)
//        requestQuery.whereKey(ParseRequestCleanPerson, equalTo: cleanPerson)
//        requestQuery.findObjectsInBackgroundWithBlock { (result: [PFObject]?, error: NSError?) in
//            if result!.count == 0 {
                //Set up new Request object
                let requestObject = PFObject(className: ParseRequestClass)
                requestObject[ParseCustomer] = customer
                requestObject[ParseCleanPerson] = cleanPerson
                requestObject[ParseRequestAgree] = NSNumber(bool: false)
                requestObject[ParseRequestChecked] = NSNumber(bool: false)
                requestObject.saveInBackgroundWithBlock(block)
//            }
//        }
        
        
    }
    
    static func initReview(stars: NSNumber, description: String, customer: PFUser, cleanPerson: PFUser) {
        let reviewObject = PFObject(className: ParseReviewClass)
        reviewObject[ParseCustomer] = customer
        reviewObject[ParseCleanPerson] = cleanPerson
        reviewObject[ParseReviewDescription] = description
        reviewObject[ParseReviewStar] = stars
        cleanPerson.saveInBackground()
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
        requestQuery.whereKey(ParseCleanPerson, equalTo: cleanPerson)
        requestQuery.whereKey(ParseCustomer, equalTo: customer)
        requestQuery.findObjectsInBackgroundWithBlock(completionBlock)            
//        requestQuery.getFirstObjectInBackgroundWithBlock(completionBlock)
    }
    
    
    static func fetchReviews(range: Range<Int>, cleanPerson: PFUser, completionBlock: PFQueryArrayResultBlock) {
        let reviewsQuery = PFQuery(className: ParseReviewClass)
        reviewsQuery.whereKey(ParseCleanPerson, equalTo: cleanPerson)
        reviewsQuery.includeKey(ParseCustomer)
        
        reviewsQuery.skip = range.startIndex
        reviewsQuery.limit = range.endIndex - range.startIndex
        reviewsQuery.findObjectsInBackgroundWithBlock(completionBlock)
        
    }
}

