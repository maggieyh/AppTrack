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

    var requestCleanPersons: [PFUser] = []
    
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
        requestQuery.selectKeys(["cleanPerson"])
        requestQuery.findObjectsInBackgroundWithBlock { (result: [PFObject]?, error: NSError?) in
            if let result = result {
                self.requestCleanPersons = result as! [PFUser]
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
        return self.requestCleanPersons.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("sentRequestCell", forIndexPath: indexPath) as! sentRequestTableViewCell
        let person = self.requestCleanPersons[indexPath.row]
        cell.nameLabel.text = person.username
        return cell
        
    }
}
