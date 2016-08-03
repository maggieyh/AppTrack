//
//  customerProfileViewController.swift
//  ChoreSolver
//
//  Created by yao  on 7/12/16.
//  Copyright © 2016 yao . All rights reserved.
//

import UIKit
import Parse
class CustomerProfileViewController: UIViewController {
    
    var request: Request?
   
    @IBOutlet weak var replyBarButton: UIBarButtonItem!
    @IBAction func replyButtonTapped(sender: AnyObject) {
        self.navigationItem.rightBarButtonItem = nil
        self.request?.agree = NSNumber(bool: true)
        self.request?.saveInBackground()
        
        let alertController: UIAlertController = UIAlertController(title: "傳個訊息吧", message: "有任何事想詢問？", preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler(nil)
        var message: UITextField?
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction) in
            message = (alertController.textFields?.first)!
            if message!.text == nil {
                message!.text = ""
            }
            
            let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
            
            if let customerOneSignalID = self.request!.customer.oneSignalID as? String {
                let jsonData = ["app_id": "6f185136-e88e-4421-84b2-f8e681c0da7e","include_player_ids": [customerOneSignalID],"contents": ["en": "You recieved \(PFUser.currentUser()!.username!)'s info. Contact each other !!\n\(message!.text!)","zh":"您收到\(PFUser.currentUser()!.username!)的聯繫方式. 聯絡對方吧 !!\n\(message!.text!)" ]]
                
                appDelegate!.oneSignal!.postNotification(jsonData)
            }
            
        }))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var customerImageView: UIImageView!
    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var contactMethodTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if request!.agree.boolValue {
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.rightBarButtonItem?.enabled = false
        }
        let customer = request!.customer
        customerImageView.image = customer.image.value
        self.customerNameLabel.text = customer.username!
        self.contactMethodTextView.editable = false
        let email = customer.email!
        let phone = customer.phoneNumber as! String
        let str = "電子郵件: " + email + "\n電話： " + phone
        self.contactMethodTextView.text = str
        
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
