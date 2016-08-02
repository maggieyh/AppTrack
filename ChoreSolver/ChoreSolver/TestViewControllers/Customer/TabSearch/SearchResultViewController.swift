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
import Mixpanel
class SearchResultViewController: UIViewController, TimelineComponentTarget {

    
    
//    @IBOutlet weak var backToSearchBarButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var activate: Bool = false
    var cleanPersons: [User] = []
    var selectedCounty: String?
    let defaultRange = 0...4
    let additionalRangeSize = 5
    var indexPath: NSIndexPath? //selected indexPath
    var timelineComponent: TimelineComponent<User, SearchResultViewController>!
    var oneSignal: OneSignal?
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
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        self.oneSignal = appDelegate?.oneSignal
                
    }
    @IBAction func unwindBackToResultView(segue:UIStoryboardSegue) {
        let segueVC = segue.sourceViewController as! CleanPersonDetailViewController
        let cell = self.tableView.cellForRowAtIndexPath(self.indexPath!) as! SearchResultTableViewCell
        SearchResultTableViewCell.stateCache[cell.cleanPersonNameLabel.text!] = segueVC.stateOfRequest
        cell.stateRequest.value = segueVC.stateOfRequest
        if let value = segueVC.stateOfRequest {
            switch(value){
            case 1:
                //agree
                cell.requestButton.setTitle("Contact!", forState: UIControlState.Normal)
                cell.requestButton.enabled = false
                cell.requestButton.backgroundColor = UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 1.0)
                cell.requestButton.layer.borderColor = UIColor.clearColor().CGColor
                cell.requestButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            case 2:
                cell.requestButton.setTitle("Requested", forState: UIControlState.Normal)
                cell.requestButton.enabled = false
                cell.requestButton.backgroundColor = UIColor(red: 34/255, green: 192/255, blue: 100/255, alpha: 1.0)
                cell.requestButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            default:
                cell.requestButton.enabled = true
               
            }
            
        }
        
        
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showCleanPersonDetailFromResultView" {
            let cleanPersonDetailViewController = segue.destinationViewController as! CleanPersonDetailViewController
            cleanPersonDetailViewController.fromRequestView = false
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                self.indexPath = indexPath
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
        let token = "8e1c066cd654c81cf568464c44181e91"
        Mixpanel.sharedInstanceWithToken(token)
        let mixpanel = Mixpanel.sharedInstance()
        mixpanel.track("Search", properties: ["county": "\(self.selectedCounty!)"])
    }

    
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
        cell.delegate = self
        self.customizeButton(cell.requestButton)
        return cell
    }
    
    
    
}
extension SearchResultViewController: searchResultDelegate {
    func requestButtonTap(cleanPerson: User) {
        
        FeatureHelper.postNotification(self, oneSignal: self.oneSignal!, cleanPerson: cleanPerson)
    }
    func customizeButton(button: UIButton!) {
//        button.setBackgroundImage(nil, forState: .Normal)
//        button.backgroundColor = UIColor.clearColor()
        button.layer.cornerRadius = 13
        button.layer.borderWidth = 1
//         button.layer.borderColor = UIColor.blackColor().CGColor
    }
}

