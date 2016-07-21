//
//  CustomerReqeustViewController.swift
//  ChoreSolver
//
//  Created by yao  on 7/11/16.
//  Copyright © 2016 yao . All rights reserved.
//

import UIKit
import Parse
class CustomerReqeustViewController: UIViewController {

    var requests: [Request] = []
    var cleanPersons: [User] = []
    @IBOutlet weak var requestTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.requestTableView.estimatedRowHeight = 80.0
        self.requestTableView.rowHeight = UITableViewAutomaticDimension
    }

    @IBAction func unwindBackToRequestView(segue:UIStoryboardSegue) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showCleanPersonProfileFromRequest" {
            let cleanPersonDetailViewController = segue.destinationViewController as! CleanPersonDetailViewController
            if let indexPath = self.requestTableView.indexPathForSelectedRow {
                cleanPersonDetailViewController.cleanPerson = requests[indexPath.row].cleanPerson
                if requests[indexPath.row].agree.boolValue {
                    cleanPersonDetailViewController.stateOfRequest = 1
                } else {
                    cleanPersonDetailViewController.stateOfRequest = 2
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let requestQuery = PFQuery(className: "Request")
        requestQuery.whereKey("customer", equalTo: PFUser.currentUser()!)
        requestQuery.includeKey("cleanPerson")
        requestQuery.findObjectsInBackgroundWithBlock { (result: [PFObject]?, error: NSError?) in
            let result = result as! [Request]
            self.requests = result
            self.cleanPersons = result.map { $0.cleanPerson }
            self.requestTableView.reloadData()
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

extension CustomerReqeustViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.requests.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("sentRequestCell", forIndexPath: indexPath) as! sentRequestTableViewCell
        let request = self.requests[indexPath.row]
        let cleanPerson = request.cleanPerson
        cell.cleanPerson = cleanPerson
        cleanPerson.downloadImage()
        
        cell.nameLabel.text = cleanPerson.username
        cell.hourRateLabel.text = ((cleanPerson["hourRate"] as? String) ?? "" ) + "$/hr"
        if request.agree.boolValue {
            cell.stateLabel.text = "Contact Info Received, Contact " + cell.nameLabel.text! + "!"
        } else {
            cell.stateLabel.text = "Request Sent, Wait for Response"
        }
  
        
        return cell
        
    }
}
