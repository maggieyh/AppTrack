//
//  TestRequestViewController.swift
//  ChoreSolver
//
//  Created by yao  on 7/10/16.
//  Copyright © 2016 yao . All rights reserved.
//

import UIKit
import Parse
import ConvenienceKit
class TestRequestViewController: UIViewController {

    //var cleanPersons: [CleanPerson] = []
    
    
    @IBOutlet weak var customerNameLabel: UILabel!
    //@IBOutlet weak var searchResultTableView: UITableView!
    
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
        
        let cleanpersonQuery = PFQuery(className: "User")
        cleanpersonQuery.whereKey("userType", equalTo: "CleanPerson")
        
        cleanpersonQuery.findObjectsInBackgroundWithBlock { (result: [PFObject]?, error: NSError?) in
                if let result = result {
                    print("enter")
                    for ele in result {
                        print(ele["username"])
                    }
                } else {
                    print("fail")
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

//extension TestRequestViewController: UITableViewDataSource {
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("CleanPersonCell", forIndexPath: indexPath) as! SearchResultTableViewCell
//        cell.imageView?.image = UIImage(named: "search")
//        cell.cleanPersonNameLabel?.text = "aName"
//        
//        return cell
//    }
//}
