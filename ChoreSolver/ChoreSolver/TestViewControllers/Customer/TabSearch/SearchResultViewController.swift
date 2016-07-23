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
import Foundation
class SearchResultViewController: UIViewController {

    @IBOutlet weak var searchResultTableView: UITableView!
    
    var cleanPersons: [User] = []
    var selectedCounty: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        SearchResultTableViewCell.stateCache = NSCacheSwift<String, Int?>()
        
    }
    @IBAction func unwindBackToResultView(segue:UIStoryboardSegue) {
    }
    @IBAction func unwindBackToRequestView(segue:UIStoryboardSegue) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showCleanPersonDetailFromResultView" {
            let cleanPersonDetailViewController = segue.destinationViewController as! CleanPersonDetailViewController
            if let indexPath = self.searchResultTableView.indexPathForSelectedRow {
                cleanPersonDetailViewController.cleanPerson = cleanPersons[indexPath.row]
                let cell = self.searchResultTableView.cellForRowAtIndexPath(indexPath) as! SearchResultTableViewCell
                cleanPersonDetailViewController.stateOfRequest = cell.stateRequest.value
 
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        ParseHelper.searchResultViewRequestForCleanPerson(self.selectedCounty!){ (result:[PFObject]?, error: NSError?) in
            self.cleanPersons = result as? [User] ?? []
            
            
            self.searchResultTableView.reloadData()
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

extension SearchResultViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cleanPersons.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CleanPersonCell", forIndexPath: indexPath) as! SearchResultTableViewCell
        let person = cleanPersons[indexPath.row]
        person.downloadImage()
        cell.cleanPersonNameLabel.text = person.username!
        cell.cleanPerson = person
        let str = (person.hourRate as? String) ?? ""
        cell.hourRateLabel.text = str + "$/hr"
        cell.tabBarViewController = self.tabBarController ?? nil
        cell.requestButton.enabled = false
        
        cell.fetchRequest()        
        return cell
    }
    
    
}


