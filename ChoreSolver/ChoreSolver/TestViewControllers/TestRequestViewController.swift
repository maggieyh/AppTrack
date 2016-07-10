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
    
    @IBOutlet weak var searchResultTableView: UITableView!

    var cleanPersons: [PFUser] = []
    var imageData: [NSData] = []
    var numOfClean: Int?
    
 
    
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
        let cleanPersonQuery : PFQuery = PFUser.query()!
        cleanPersonQuery.whereKey("userType", equalTo: "CleanPerson")
        cleanPersonQuery.whereKey("county", equalTo: "Hualien")
        cleanPersonQuery.findObjectsInBackgroundWithBlock { (result:[PFObject]?, error: NSError?) in
            if let result = result {
                self.cleanPersons = result as! [PFUser]
                self.numOfClean = result.count
                self.searchResultTableView.reloadData()
                for ele in result {
                    let imageFile = ele["imageFile"] as! PFFile
                    do {
                        let data = try imageFile.getData()
                        self.imageData.append(data)
                    } catch {
                        print("fail")
                    }
                    
                }
                print(self.imageData.count)
            } else {
                print(error)
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

extension TestRequestViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let num = numOfClean ?? 0
        return num
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CleanPersonCell", forIndexPath: indexPath) as! SearchResultTableViewCell
        let person = cleanPersons[indexPath.row]
//        do {
//            let imageFile = person["imageFile"] as! PFFile
            
//            cell.imageView?.image = UIImage(data: data, scale: 1.0)
//        } catch {
        cell.imageView?.image = UIImage(named: "search")
//        }
        
        
        cell.cleanPersonNameLabel.text = person.username!
        
        
        return cell
    }
}
