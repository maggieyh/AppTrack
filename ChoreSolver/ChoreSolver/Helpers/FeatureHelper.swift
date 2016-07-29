//
//  featureHelper.swift
//  ChoreSolver
//
//  Created by yao  on 7/28/16.
//  Copyright © 2016 yao . All rights reserved.
//

import Foundation
import Parse

class FeatureHelper {
    
    static func postNotification(viewController: UIViewController, oneSignal: OneSignal, cleanPerson: User){
        let alertController: UIAlertController = UIAlertController(title: "Send a message", message: "Anything you want to tell", preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler(nil)
        var message: UITextField?
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction) in
                message = (alertController.textFields?.first)!
                if message!.text == nil {
                    message!.text = ""
                }
        }))

        viewController.presentViewController(alertController, animated: true, completion: nil)
        
        ParseHelper.initRequestInfo(PFUser.currentUser()!, cleanPerson: cleanPerson, block: { (success: Bool, error: NSError?) in
                let customerName = PFUser.currentUser()?.username!
                
                if let cleanPersonOneSignalID = cleanPerson.oneSignalID as? String {
                    let jsonData = ["app_id": "6f185136-e88e-4421-84b2-f8e681c0da7e","include_player_ids": [cleanPersonOneSignalID],"contents": ["en": "\(customerName!) sent a request for your contact info! Reply \(customerName!)! \n \(message!.text!)"]]
                    oneSignal.postNotification(jsonData)
                }
            })
    }
        
    
}

