//
//  CleanPersonRequestViewController.swift
//  ChoreSolver
//
//  Created by yao  on 7/11/16.
//  Copyright © 2016 yao . All rights reserved.
//

import UIKit
import Parse
import ConvenienceKit
class CleanPersonRequestViewController: UIViewController, TimelineComponentTarget {

    @IBOutlet weak var requestTableView: UITableView!
    var requests: [Request] = []
    var customer: [User] = []
    let defaultRange = 0...4
    let additionalRangeSize = 5
    var timelineComponent: TimelineComponent<User, CleanPersonRequestViewController>!
    var tableView: UITableView!
    func loadInRange(range: Range<Int>, completionBlock: ([User]?) -> Void) {
        // 1
        
        let requestQuery = PFQuery(className: "Request")
        requestQuery.whereKey("cleanPerson", equalTo: PFUser.currentUser()!)
        requestQuery.includeKey("customer")
        requestQuery.findObjectsInBackgroundWithBlock { (result: [PFObject]?, error: NSError?) in
            if let result = result {
                
                self.requests = result as! [Request]
                self.customer = self.requests.map { $0.customer }
                completionBlock(self.customer)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView = self.requestTableView
        // Do any additional setup after loading the view.
        self.requestTableView.estimatedRowHeight = 80.0
        self.requestTableView.rowHeight = UITableViewAutomaticDimension
        timelineComponent = TimelineComponent(target: self)
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
                self.requestTableView.deselectRowAtIndexPath(indexPath, animated: true)
                if viewController.request!.agree.boolValue {
                    viewController.navigationItem.rightBarButtonItem = nil
                } 
            }
            

        }
    }
 
  
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        let requestQuery = PFQuery(className: "Request")
//        requestQuery.whereKey("cleanPerson", equalTo: PFUser.currentUser()!)
//        requestQuery.includeKey("customer")
//        requestQuery.findObjectsInBackgroundWithBlock { (result: [PFObject]?, error: NSError?) in
//            if let result = result {
//                
//                self.requests = result as! [Request]
//                self.customer = self.requests.map { $0.customer }
//                self.requestTableView.reloadData()
//                print(self.requests.count)
//            }
        
         timelineComponent.loadInitialIfRequired()
//        }
        
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
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        timelineComponent.targetWillDisplayEntry(indexPath.row)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return requests.count
        return timelineComponent.content.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cleanPersonRequestCell", forIndexPath: indexPath) as! cleanPersonRequestTableViewCell
        cell.request = self.requests[indexPath.row]
        self.customer[indexPath.row].downloadImage()
        
        cell.customer = self.customer[indexPath.row]
        cell.customerNameLabel.text = self.customer[indexPath.row].username!
        
        if requests[indexPath.row].agree.boolValue {
            cell.replyButton.hidden = true
            cell.requestStateLabel.text = "聯繫顧客以提供您的服務!" //\(self.customer[indexPath.row].username!)
            cell.trailingConstraint.constant = 0
        } else {
            cell.replyButton.hidden = false
            cell.requestStateLabel.text = "一則希望聯繫您的詢問!" //\A request for your contact(self.customer[indexPath.row].username!) sent a
            cell.trailingConstraint.constant = 60
        }
        cell.request = requests[indexPath.row]
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
}

extension CleanPersonRequestViewController: tableViewCellNotificationDelegate {
    
    func presentViewController(alertController: UIAlertController, indexPath: NSIndexPath){
        print("fasdf")
        self.presentViewController(alertController, animated: true, completion: nil)
        let cell = self.requestTableView.cellForRowAtIndexPath(indexPath) as! cleanPersonRequestTableViewCell
        cell.replyButton.hidden = true
        cell.requestStateLabel.text = "聯繫 \(self.customer[indexPath.row].username!) 提供您的服務!"
        cell.trailingConstraint.constant = 0
    }
}
