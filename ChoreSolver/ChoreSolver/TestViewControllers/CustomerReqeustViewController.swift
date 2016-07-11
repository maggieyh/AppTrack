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
        let reqeustQuery = PFQuery(className: "Request")
        reqeustQuery.whereKey("customer", equalTo: PFUser.currentUser()!)
//        
//        cleanPersonQuery.whereKey("userType", equalTo: "CleanPerson")
//        cleanPersonQuery.whereKey("county", equalTo: "Hualien")
//        cleanPersonQuery.findObjectsInBackgroundWithBlock { (result:[PFObject]?, error: NSError?) in
//            if let result = result {
//                self.cleanPersons = result as! [PFUser]
//                self.numOfClean = result.count
//                self.searchResultTableView.reloadData()
//                self.imageData = []
//                for ele in result {
//                    let imageFile = ele["imageFile"] as! PFFile
//                    do {
//                        let data = try imageFile.getData()
//                        self.imageData.append(data)
//                    } catch {
//                        print("fail")
//                        self.imageData.append(nil)
//                    }
//                    
//                }
//                print(self.imageData.count)
//            } else {
//                print(error)
//            }
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

extension CustomerReqeustViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("sentRequestCell", forIndexPath: indexPath) as! sentRequestTableViewCell
        return cell
        
    }
}
