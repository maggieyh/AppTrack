//
//  CustomerReqeustViewController.swift
//  ChoreSolver
//
//  Created by yao  on 7/11/16.
//  Copyright © 2016 yao . All rights reserved.
//

import UIKit
import Parse
import Mixpanel
class CustomerReqeustViewController: UIViewController {

    var requests: [Request] = []
    var cleanPersons: [User] = []
    
    @IBOutlet weak var requestTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.requestTableView.estimatedRowHeight = 80.0
        self.navigationController!.navigationBar.barTintColor = UIColor.whiteColor()
        self.navigationController!.navigationBar.titleTextAttributes =  [ NSFontAttributeName: UIFont.systemFontOfSize(17, weight: UIFontWeightRegular) ]
//        self.requestTableView.rowHeight = UITableViewAutomaticDimension
        let token = "8e1c066cd654c81cf568464c44181e91"
        Mixpanel.sharedInstanceWithToken(token)
        let mixpanel = Mixpanel.sharedInstance()
        mixpanel.track("Request view")
    }

    @IBAction func unwindBackToRequestView(segue:UIStoryboardSegue) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showCleanPersonProfileFromRequest" {
            let cleanPersonDetailViewController = segue.destinationViewController as! CleanPersonDetailViewController
            cleanPersonDetailViewController.fromRequestView = true
            if let indexPath = self.requestTableView.indexPathForSelectedRow {
                cleanPersonDetailViewController.cleanPerson = requests[indexPath.row].cleanPerson
                let str = cleanPersonDetailViewController.cleanPerson?.username
                cleanPersonDetailViewController.navigationBarItem.title = str! + "'s profile"
                if requests[indexPath.row].agree.boolValue {
                    print("in")
                    cleanPersonDetailViewController.stateOfRequest = 1 //agree
                    if !(requests[indexPath.row].checked.boolValue) {
                        requests[indexPath.row].checked = NSNumber(bool: true)
                        requests[indexPath.row].saveInBackground()
                        
                        if self.tabBarController?.tabBar.items![1].badgeValue != nil {
                        
                            let num = Int((self.tabBarController?.tabBar.items![1].badgeValue)!)
                            print(num)
                            if num <= 1 {
                                self.tabBarController?.tabBar.items![1].badgeValue = nil
                            } else {
                                self.tabBarController?.tabBar.items![1].badgeValue = String(num!-1)
                            }
                            
                        }
                    }
                } else {
                    cleanPersonDetailViewController.stateOfRequest = 2 //not yet respond
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
        print(self.requests.count)
        return self.requests.count ?? 0
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("sentRequestCell", forIndexPath: indexPath) as! sentRequestTableViewCell
        let request = self.requests[indexPath.row]
        let cleanPerson = request.cleanPerson
        cell.cleanPerson = cleanPerson
    
        if let _ = cleanPerson.imageFile?.name {
            cleanPerson.downloadImage()
        }
        cell.nameLabel.text = cleanPerson.username
        cell.hourRateLabel.text = ((cleanPerson["hourRate"] as? String) ?? "" ) + "$/hr"
        if request.agree.boolValue {
            cell.stateLabel.text = "Received"
            cell.stateImage.image = UIImage(named: "received")
            
        } else {
            cell.stateLabel.text = "Wait.."
            cell.stateImage.image = UIImage(named: "hourglass")
        }
//        
//        let reviewPoll = PFQuery(className: "ReviewsPoll")
//        reviewPoll.whereKey("cleanPerson", equalTo: cell.cleanPerson!)
//        reviewPoll.findObjectsInBackgroundWithBlock { (result: [PFObject]?, error: NSError?) in
//            if let result = result {
//                print(result[0].objectId)
//            }
//        }
  
        
        return cell
        
    }
}
