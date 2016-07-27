//
//  CleanPersonRequestViewController.swift
//  ChoreSolver
//
//  Created by yao  on 7/11/16.
//  Copyright © 2016 yao . All rights reserved.
//

import UIKit
import Parse
class CleanPersonRequestViewController: UIViewController {

    @IBOutlet weak var requestTableView: UITableView!
    var requests: [Request] = []
    var customer: [User] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.requestTableView.estimatedRowHeight = 80.0
        self.requestTableView.rowHeight = UITableViewAutomaticDimension
    }

    @IBAction func unwindBackToCleanPersonRequestView(segue:UIStoryboardSegue) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showCustomerProfile" {
            let viewController = segue.destinationViewController as! CustomerProfileViewController
            if let indexPath = self.requestTableView.indexPathForSelectedRow{
                viewController.request = requests[indexPath.row]
                
                if viewController.request!.agree.boolValue {
                    viewController.navigationItem.rightBarButtonItem = nil
                } 
            }
            

        }
    }
 
  
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let requestQuery = PFQuery(className: "Request")
        requestQuery.whereKey("cleanPerson", equalTo: PFUser.currentUser()!)
        requestQuery.includeKey("customer")
        requestQuery.findObjectsInBackgroundWithBlock { (result: [PFObject]?, error: NSError?) in
            if let result = result {
                
                self.requests = result as! [Request]
                self.customer = self.requests.map { $0.customer }
                self.requestTableView.reloadData()
                print(self.requests.count)
            }
        }
        
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

extension CleanPersonRequestViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requests.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cleanPersonRequestCell", forIndexPath: indexPath) as! cleanPersonRequestTableViewCell
        cell.request = self.requests[indexPath.row]
        self.customer[indexPath.row].downloadImage()
        
        cell.customer = self.customer[indexPath.row]
        cell.customerNameLabel.text = self.customer[indexPath.row].username!
        
        if requests[indexPath.row].agree.boolValue {
            cell.replyButton.hidden = true
            cell.requestStateLabel.text = "Contact \(self.customer[indexPath.row].username!) to provide your service"
        } else {
            cell.replyButton.hidden = false
            cell.requestStateLabel.text = "\(self.customer[indexPath.row].username!) sent a request for your contact!"
        }
        cell.request = requests[indexPath.row]
        return cell
    }
}
