//
//  reviewViewController.swift
//  ChoreSolver
//
//  Created by yao  on 7/28/16.
//  Copyright © 2016 yao . All rights reserved.
//

import UIKit
import Cosmos
import Parse
class ReviewPersonViewController: UIViewController, UITextViewDelegate {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LogInViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    var cleanPerson: User?
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var starRating: CosmosView!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBAction func submitButtonTapped(sender: AnyObject) {
        self.submitButton.enabled = false
        let num = starRating.rating as NSNumber
        if reviewTextView.text != "Review to support \(self.cleanPerson?.username!)!" {
            self.submitButton.enabled = false
            self.submitButton.hidden = true
            self.reviewTextView.editable = false
            self.starRating.userInteractionEnabled = false
            
            let total = self.cleanPerson!.reviewsAverage!.doubleValue * self.cleanPerson!.reviewsNum!.doubleValue
            print(total)
            self.cleanPerson!.reviewsAverage = (total + starRating.rating)/(self.cleanPerson!.reviewsNum!.doubleValue + 1) as NSNumber
            print(self.cleanPerson!.reviewsAverage?.doubleValue)
            self.cleanPerson!.reviewsNum = (self.cleanPerson!.reviewsNum!.doubleValue + 1) as NSNumber
            self.cleanPerson!.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) in
                if success {
                    print("yes")
                } else {
                    print(error)
                }
            })
            
            ParseHelper.initReview(num, description: reviewTextView.text, customer: PFUser.currentUser()!, cleanPerson: self.cleanPerson!)
            self.performSegueWithIdentifier("unwindBackToCleanPersonDetailView", sender: self)
        } else {
            let alertController = UIAlertController(title: "Something wrong", message: "you haven't typed in any review", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: false, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        starRating.settings.updateOnTouch = true
        starRating.settings.fillMode = .Full
        self.reviewTextView.delegate = self
        
        self.reviewTextView.text = "Review to support \(self.cleanPerson!.username!)!"
        self.reviewTextView.textColor = UIColor.lightGrayColor()
        self.hideKeyboardWhenTappedAround()
        
        self.reviewTextView.layer.cornerRadius = 5
        self.reviewTextView.layer.borderWidth = 1
        self.reviewTextView.layer.borderColor = UIColor.whiteColor().CGColor
        
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
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Review to support \(self.cleanPerson?.username!)!"
            textView.textColor = UIColor.lightGrayColor()
        }
    }
}
