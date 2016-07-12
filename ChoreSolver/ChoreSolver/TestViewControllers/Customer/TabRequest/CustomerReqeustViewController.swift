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
    
    @IBOutlet weak var requestTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
            if let result = result {
                self.requests = result as! [Request]
                self.requestTableView.reloadData()
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

extension CustomerReqeustViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.requests.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("sentRequestCell", forIndexPath: indexPath) as! sentRequestTableViewCell
        let request = self.requests[indexPath.row]
        let cleanPerson = request.cleanPerson
        if let cleanPerson = cleanPerson {
            print("ye")
            cell.nameLabel.text = cleanPerson.username
        }
        return cell
        
    }
}
