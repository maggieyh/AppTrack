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
    
    
//    else {
//    let alertController = UIAlertController(title: "\(viewController.request?.customer?.username) sent a request for your contact!", message: "Reply ?", preferredStyle: UIAlertControllerStyle.Alert)
//    alertController.addAction(UIAlertAction(title: "Reply", style: .Default, handler: nil))
//    alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
//    self.presentViewController(alertController, animated: true, completion: nil)
//    
//    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
