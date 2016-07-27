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
class SearchResultViewController: UIViewController, TimelineComponentTarget {

    
//    @IBOutlet weak var backToSearchBarButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var activate: Bool = false
    var cleanPersons: [User] = []
    var selectedCounty: String?
    let defaultRange = 0...6
    let additionalRangeSize = 7
    var timelineComponent: TimelineComponent<User, SearchResultViewController>!
    
    func loadInRange(range: Range<Int>, completionBlock: ([User]?) -> Void) {
        // 1
        
        ParseHelper.searchResultViewRequestForCleanPerson(range, county: selectedCounty!) { (result: [PFObject]?, error: NSError?) in
            let cleanPerson = result as! [User]?
            completionBlock(cleanPerson)
            self.navigationItem.leftBarButtonItem?.enabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        SearchResultTableViewCell.stateCache = NSCacheSwift<String, Int?>()
        
        timelineComponent = TimelineComponent(target: self)
//        self.tabBarController?.delegate = self
                
    }
    @IBAction func unwindBackToResultView(segue:UIStoryboardSegue) {
        
    }
    @IBAction func unwindBackToRequestView(segue:UIStoryboardSegue) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showCleanPersonDetailFromResultView" {
            let cleanPersonDetailViewController = segue.destinationViewController as! CleanPersonDetailViewController
        
            if let indexPath = self.tableView.indexPathForSelectedRow {
                cleanPersonDetailViewController.cleanPerson = timelineComponent.content[indexPath.row]
                let cell = self.tableView.cellForRowAtIndexPath(indexPath) as! SearchResultTableViewCell
                cleanPersonDetailViewController.stateOfRequest = cell.stateRequest.value
                let str = cell.cleanPerson?.username!
                cleanPersonDetailViewController.navigationBarItem.title =  str! + "'s profile"
                self.tableView.deselectRowAtIndexPath(indexPath, animated:true)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if self.activate {
            self.navigationItem.leftBarButtonItem?.enabled = false
            self.activate = false
        }
        timelineComponent.loadInitialIfRequired()
        
//        ParseHelper.searchResultViewRequestForCleanPerson(self.selectedCounty!){ (result:[PFObject]?, error: NSError?) in
//            self.cleanPersons = result as? [User] ?? []
//            
//            
//            self.searchResultTableView.reloadData()
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

extension SearchResultViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        timelineComponent.targetWillDisplayEntry(indexPath.row)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.cleanPersons.count ?? 0
        return timelineComponent.content.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CleanPersonCell", forIndexPath: indexPath) as! SearchResultTableViewCell
//        let person = cleanPersons[indexPath.row]
        let person = timelineComponent.content[indexPath.row]
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        cell.oneSignal = appDelegate?.oneSignal
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


