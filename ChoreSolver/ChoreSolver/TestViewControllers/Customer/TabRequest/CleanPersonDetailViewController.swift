//
//  CleanPersonDetailViewController.swift
//  ChoreSolver
//
//  Created by yao  on 7/16/16.
//  Copyright © 2016 yao . All rights reserved.
//

import UIKit
import Parse
import Bond
import Cosmos
import ConvenienceKit
class CleanPersonDetailViewController: UIViewController, UITextViewDelegate {
    var fromRequestView: Bool?
    var cleanPerson: User?
    var agree: Bool?
    var stateOfRequest: Int?
    var oneSignal: OneSignal?
    var indexPath: NSIndexPath?
    var viewController: UIViewController?

    @IBOutlet weak var ratingView: CosmosView!
    @IBAction func backBarButtonTapped(sender: AnyObject) {
        if fromRequestView! {
            self.performSegueWithIdentifier("unwindBackToRequestView", sender: self)
        } else {
            self.performSegueWithIdentifier("unwindBackToResultView", sender: self)
        }
    }
    @IBAction func unwindBackToCleanPersonDetailView(segue:UIStoryboardSegue) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showReviewsTable" {
            let VC = segue.destinationViewController as! ReviewTableViewController
            VC.reviews = self.reviews
            VC.cleanPerson = self.cleanPerson
        } else if segue.identifier == "goToReviewPage" {
            let VC = segue.destinationViewController as! ReviewPersonViewController
            VC.cleanPerson = self.cleanPerson
        }
    }
    @IBOutlet var rightBarButton: UIBarButtonItem!
    @IBOutlet weak var navigationBarItem: UINavigationItem!
    @IBOutlet weak var nameLabel: UILabel!
    @IBAction func rightBarButtonTapped(sender: AnyObject) {
        if self.rightBarButton.title == "Request" {
            self.contactMethodTextView.hidden = false
            self.contactMethodTextView.text = "Wait for \(self.nameLabel.text!)'s response"
            self.contactLabel.hidden = false
            self.navigationItem.rightBarButtonItem = nil
            self.stateOfRequest = 2
            
            FeatureHelper.postNotification(self, oneSignal: self.oneSignal!, cleanPerson: self.cleanPerson!)
        } else {
            self.performSegueWithIdentifier("goToReviewPage", sender: self)
        }
    }
    
    @IBOutlet weak var reviewsNumberButton: UIButton!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var hourRateLabel: UILabel!
    @IBOutlet weak var introductionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var introductionLabel: UILabel!
    @IBOutlet weak var contactMethodTextView: UITextView!
    func goToReviewsTable() {
        self.performSegueWithIdentifier("showReviewsTable", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        self.ratingView.settings.updateOnTouch = true
//        self.ratingView.rating = self.cleanPerson!.reviewsAverage!.doubleValue
//        self.ratingView.settings.fillMode = .Precise
//        self.reviewsNumberButton.setTitle("\(self.cleanPerson!.reviewsNum!.intValue) reviews", forState: .Normal)
//        self.view.addSubview(self.ratingView)
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(CleanPersonDetailViewController.goToReviewsTable))
//        self.ratingView.addGestureRecognizer(gesture)
        
        ParseHelper.fetchReviews(self.defaultRange, cleanPerson: self.cleanPerson!) { (result: [PFObject]?, error: NSError?) in
            self.reviews = result as? [Review] ?? []
        }
        
       
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        self.oneSignal = appDelegate?.oneSignal
        
        
        if let cleanPerson = cleanPerson {
            //????????
            cleanPerson.downloadImage()
            imageView.image = cleanPerson.image.value
            
            nameLabel.text = cleanPerson.username
            
            if let hourRate = cleanPerson["hourRate"] as? String {
                hourRateLabel.text = hourRate + "$/hr"
            } else {
                hourRateLabel.text = ""
            }
            if let intro = cleanPerson["introduction"] as? String {
                introductionTextView.text = intro
            } else {
                introductionTextView.text = ""
            }
            
            print(stateOfRequest)
            if let value = stateOfRequest {
                switch(value){
                case 1:
                    //agree
                    let email = cleanPerson.email!
                    let phone = cleanPerson["phoneNumber"]! as! String
                    let str = "Email addresss: " + email + "\nPhone number: " + phone
                    contactMethodTextView.text = str
                    //review bar button
                    self.rightBarButton.title = "Review"
                case 2:
                    //not yet respond
                    contactMethodTextView.text = "Wait for \(nameLabel.text!)'s response"
                    //X
                    self.navigationItem.rightBarButtonItem = nil
                    
                default:
                    contactMethodTextView.hidden = true
                    contactLabel.hidden = true
                     //request
                    self.rightBarButton.title = "Request"
                }
            } else {
                contactMethodTextView.hidden = true
                contactLabel.hidden = true
            }

        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        ParseHelper.fetchReviews(self.defaultRange, cleanPerson: self.cleanPerson!) { (result: [PFObject]?, error: NSError?) in
            self.reviews = result as? [Review] ?? []
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: TimelineComponent
    let defaultRange = 0...4
    let additionalRangeSize = 5
    var reviews: [Review]? = []
}

