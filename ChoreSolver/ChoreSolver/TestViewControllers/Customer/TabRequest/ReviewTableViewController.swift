//
//  ReviewTableViewController.swift
//  ChoreSolver
//
//  Created by yao  on 7/30/16.
//  Copyright © 2016 yao . All rights reserved.
//

import UIKit
import ConvenienceKit
import Parse
import Mixpanel
class ReviewTableViewController: UIViewController, TimelineComponentTarget {

    let defaultRange = 5...9
    let additionalRangeSize = 5
    var timelineComponent: TimelineComponent<Review, ReviewTableViewController>!
    @IBOutlet weak var tableView: UITableView!
    var reviews: [Review]? = []
    var cleanPerson: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
         timelineComponent = TimelineComponent(target: self)
        
        let token = "8e1c066cd654c81cf568464c44181e91"
        Mixpanel.sharedInstanceWithToken(token)
        let mixpanel = Mixpanel.sharedInstance()
        mixpanel.track("Reviews Table")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var first: Bool? = true
    func loadInRange(range: Range<Int>, completionBlock: ([Review]?) -> Void) {
        ParseHelper.fetchReviews(range, cleanPerson: self.cleanPerson!) { (result: [PFObject]?, error: NSError?) -> Void in
            
            var reviews = result as? [Review] ?? []
            if self.first! {
                reviews = self.reviews! + reviews
                self.first = false
            }
            completionBlock(reviews)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        timelineComponent.loadInitialIfRequired()
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

extension ReviewTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timelineComponent.content.count
//        return self.reviews!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reviewTableViewCell", forIndexPath: indexPath) as! ReviewsTableViewCell
        cell.comment.text = timelineComponent.content[indexPath.row].comment as String
        cell.ratings.rating = timelineComponent.content[indexPath.row].stars.doubleValue
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        timelineComponent.targetWillDisplayEntry(indexPath.row)
    }

}
