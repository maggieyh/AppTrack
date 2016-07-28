//
//  CleanPersonDetailViewController.swift
//  ChoreSolver
//
//  Created by yao  on 7/16/16.
//  Copyright © 2016 yao . All rights reserved.
//

import UIKit
import Parse
class CleanPersonDetailViewController: UIViewController {
    var fromRequestView: Bool?
    var cleanPerson: User?
    var agree: Bool?
    var stateOfRequest: Int?
    var oneSignal: OneSignal?
    var indexPath: NSIndexPath?
    var viewController: UIViewController?
    @IBAction func backBarButtonTapped(sender: AnyObject) {
        if fromRequestView! {
            self.performSegueWithIdentifier("unwindBackToRequestView", sender: self)
        } else {
            self.performSegueWithIdentifier("unwindBackToResultView", sender: self)
        }
    }
    
    @IBOutlet var rightBarButton: UIBarButtonItem!
    @IBOutlet weak var navigationBarItem: UINavigationItem!
    @IBOutlet weak var nameLabel: UILabel!
    @IBAction func rightBarButtonTapped(sender: AnyObject) {
        if self.rightBarButton.title == "Request" {
            self.contactMethodTextView.hidden = false
            self.contactMethodTextView.text = "Wait for \(self.nameLabel.text!)'s response"
            self.contactLabel.hidden = false
            self.navigationItem.rightBarButtonItem = nil
            self.stateOfRequest = 2
            let alertController: UIAlertController = UIAlertController(title: "Send a message", message: "Anything you want to tell", preferredStyle: .Alert)
            alertController.addTextFieldWithConfigurationHandler(nil)
            let okAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) in
                let message: UITextField = (alertController.textFields?.first)!
                print(message.text)
            })
            alertController.addAction(okAction)
//            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
//            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: false, completion: nil)

            ParseHelper.initRequestInfo(PFUser.currentUser()!, cleanPerson: cleanPerson!, block: { (success: Bool, error: NSError?) in
                let customerName = PFUser.currentUser()?.username!
                
                if let cleanPersonOneSignalID = self.cleanPerson?.oneSignalID as? String {
                    let jsonData = ["app_id": "6f185136-e88e-4421-84b2-f8e681c0da7e","include_player_ids": [cleanPersonOneSignalID],"contents": ["en": "\(customerName) sent a request for your contact info! Reply \(customerName)!"]]
                    self.oneSignal?.postNotification(jsonData)
                }
            })
        } else {
            
        }
    }
    
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var hourRateLabel: UILabel!
    @IBOutlet weak var introductionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var introductionLabel: UILabel!
    @IBOutlet weak var contactMethodTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        self.oneSignal = appDelegate?.oneSignal
        
        
        if let cleanPerson = cleanPerson {
            cleanPerson.downloadImage()
            imageView.image = cleanPerson.image.value
            nameLabel.text = cleanPerson.username
            
            if let hourRate = cleanPerson["hourRate"] as? String {
                hourRateLabel.text = hourRate + "$/hr"
            } else {
                hourRateLabel.text = ""
            }
            if let intro = cleanPerson["introduction"] as? String {
                introductionTextView.text = intro
            } else {
                introductionTextView.text = ""
            }
            
            if let value = stateOfRequest {
                switch(value){
                case 1:
                    //agree
                    let email = cleanPerson.email!
                    let phone = cleanPerson["phoneNumber"]! as! String
                    let str = "Email addresss: " + email + "\nPhone number: " + phone
                    contactMethodTextView.text = str
                    //review bar button
                    self.rightBarButton.title = "Review"
                case 2:
                    //not yet respond
                    contactMethodTextView.text = "Wait for \(nameLabel.text!)'s response"
                    //X
                    self.navigationItem.rightBarButtonItem = nil
                    
                default:
                    contactMethodTextView.hidden = true
                    contactLabel.hidden = true
                    //request
                    self.rightBarButton.title = "Request"
                }
            } else {
                contactMethodTextView.hidden = true
                contactLabel.hidden = true
            }

        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
