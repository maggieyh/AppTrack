//
//  RegisterViewController.swift
//  ChoreSolver
//
//  Created by yao  on 7/14/16.
//  Copyright © 2016 yao . All rights reserved.
//

import UIKit
import Parse
//import DropDown
import ParseUI
class RegisterViewController: UIViewController,UIPopoverPresentationControllerDelegate {
    var backgroundImage : UIImageView!
    //let countyDropDown = DropDown()
    
    let customerData = ["Name", "Email", "Phone Number"]
    let cleanPersonData = ["Name", "Email", "Phone Number","Hour Rate" ]
    var userType: String = "Customer"
    var textFields: [UITextField!]?
    
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    //for Clean Person
    @IBOutlet weak var hourRateTextField: UITextField!
    @IBOutlet weak var introductionTextView: UITextView!
    @IBOutlet weak var countyButton: UIButton!
    
    @IBAction func chooseCounty(sender: AnyObject) {
        //countyDropDown.show()
    }

    @IBAction func userTypeToggled(sender: AnyObject) {
        if userType == "CleanPerson" {
            userType = "Customer"
            self.countyButton.hidden = true
            self.introductionTextView.hidden = true
            self.hourRateTextField.hidden = true
        } else {
            userType = "CleanPerson"
            self.countyButton.hidden = false
            self.introductionTextView.hidden = false
            self.hourRateTextField.hidden = false
        }
    }

    
    
    @IBAction func doneTapped(sender: AnyObject) {
         //make new user
        var finished: Bool = true
        for ele in self.textFields! {
            if ele.text == nil {
                finished = false
                break
            }
        }
        
        if finished {
            let username = self.userNameTextField.text!
            let password = self.passwordTextField.text
            let email = self.emailTextField.text
            let finalEmail = email!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            
            let newUser = PFUser()
            
            newUser.username = username
            newUser.password = password
            newUser.email = finalEmail
            
            // Sign up the user asynchronously
            newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                
                // Stop the spinner
//                spinner.stopAnimating()
                if ((error) != nil) {
                    print(error)
                    
                } else {
                    print("sucess")
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        if self.userType == "Customer" {
                            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CustomerTabBarController") as! UITabBarController
                            self.presentViewController(viewController, animated: true, completion: nil)
                        } else {
                            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CleanPersonTabBarController") as! UITabBarController
                            self.presentViewController(viewController, animated: true, completion: nil)
                        }

    
                    })
                }
            })
            
            
            
        } else {
            print("invalid something incomplete")
        }
    
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
     //   self.setupChooseCountyDropDown()
        
        self.textFields = [self.userNameTextField, self.passwordTextField, self.emailTextField, self.phoneNumberTextField]
        
        self.countyButton?.hidden = true
        self.introductionTextView?.hidden = true
        self.hourRateTextField?.hidden = true
        
        // set our custom background image
        //        backgroundImage = UIImageView(image: UIImage(named: "welcome_bg"))
        //        backgroundImage.contentMode = UIViewContentMode.ScaleAspectFill
        //        signUpView!.insertSubview(backgroundImage, atIndex: 0)
        //
        // remove the parse Logo
//        let logo = UILabel()
//        logo.text = "Vay.K"
//        logo.textColor = UIColor.whiteColor()
//        logo.font = UIFont(name: "Pacifico", size: 70)
//        logo.shadowColor = UIColor.lightGrayColor()
//        logo.shadowOffset = CGSizeMake(2, 2)
//        signUpView?.logo = logo
        
//        self.signUpView?.signUpButton
        
        
    }
/*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // stretch background image to fill screen
        backgroundImage.frame = CGRectMake( 0,  0,  signUpView!.frame.width,  signUpView!.frame.height)
        
        // position logo at top with larger frame
        signUpView!.logo!.sizeToFit()
        let logoFrame = signUpView!.logo!.frame
        signUpView!.logo!.frame = CGRectMake(logoFrame.origin.x, signUpView!.usernameField!.frame.origin.y - logoFrame.height - 16, signUpView!.frame.width,  logoFrame.height)
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    /*func setupChooseCountyDropDown() {
        countyDropDown.anchorView = countyButton
        
        // Will set a custom with instead of anchor view width
        //		dropDown.width = 100
        
        // By default, the dropdown will have its origin on the top left corner of its anchor view
        // So it will come over the anchor view and hide it completely
        // If you want to have the dropdown underneath your anchor view, you can do this:
        countyDropDown.bottomOffset = CGPoint(x: 0, y: countyButton.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        countyDropDown.dataSource = [
            "Changhua County", "Chiayi City", "Chiayi County","Hsinchu City",
            "Hsinchu County", "Hualien County", "Kaohsiung City", "Keelung City", "Kinmen County", "Lienchiang County", "Miaoli County", "Nantou County", "New Taipei City", "Penghu County", "Pingtung County", "Taichung City", "Tainan City", "Taipei City", "Taitung County", "Taoyuan City", "Yilan County", "Yunlin County"
        ]
        
        // Action triggered on selection
        countyDropDown.selectionAction = { [unowned self] (index, item) in
            self.countyButton.setTitle(item, forState: .Normal)
        }
        
        // Action triggered on dropdown cancelation (hide)
        //		dropDown.cancelAction = { [unowned self] in
        //			// You could for example deselect the selected item
        //			self.dropDown.deselectRowAtIndexPath(self.dropDown.indexForSelectedRow)
        //			self.actionButton.setTitle("Canceled", forState: .Normal)
        //		}
        
        // You can manually select a row if needed
        //		dropDown.selectRowAtIndex(3)
    }*/

}



