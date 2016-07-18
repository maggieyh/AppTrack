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
        let query = PFQuery(className:"Request")
        query.getObjectInBackgroundWithId(request!.objectId!) {
            (request: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let request = request {
                request["agree"] = NSNumber(bool: true)
                request.saveInBackground()
            }
        }
        
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
        let customer = request?.customer
        if let imageFile = customer!["imageFile"] as? PFFile {
            do {
                let data = try imageFile.getData()
                self.customerImageView.image = UIImage(data: data, scale: 1.0)
            } catch {
                print("fail")
            }
        }
        self.customerNameLabel.text = customer?.username!
        self.contactMethodTextView.editable = false
        let email = customer!.email!
        let phone = customer!["phoneNumber"]! as! String
        let str = "Email addresss: " + email + "\nPhone number: " + phone
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
