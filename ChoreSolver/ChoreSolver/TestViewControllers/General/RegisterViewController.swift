//
//  RegisterViewController.swift
//  ChoreSolver
//
//  Created by yao  on 7/14/16.
//  Copyright © 2016 yao . All rights reserved.
//

import UIKit
import Parse
import DropDown
import ParseUI
import Parse
import IHKeyboardAvoiding

class RegisterViewController: UIViewController, UITextViewDelegate {
    var backgroundImage : UIImageView!
    let countyDropDown = DropDown()
    var userType: String = "Customer"
    var textFields: [UITextField!]?
    var photoTakingHelper: PhotoTakingHelper?
    var imageFile: PFFile?
    
    @IBOutlet weak var topLayout: NSLayoutConstraint!
    
    @IBOutlet var spinner:UIActivityIndicatorView!
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    //for Clean Person
    var county: String? = nil
    @IBOutlet weak var hourRateTextField: UITextField!
    @IBOutlet weak var introductionTextView: UITextView!
    @IBOutlet weak var countyButton: UIButton!
    
    @IBAction func choosePhotoTapped(sender: AnyObject) {
        //func takePhoto()
        photoTakingHelper = PhotoTakingHelper(viewController: self) { (image: UIImage?) in
            //turn the UIImage into an NSData instance because the PFFile class needs an NSData argument for its initializer.
            if let image = image {
                self.userImage.image = image
                let data = UIImagePNGRepresentation(image)
                self.imageFile = PFFile(name: "cleanPerson.jpg", data: data!)
            }
            
        }
    }
    @IBAction func chooseCounty(sender: AnyObject) {
        countyDropDown.show()
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
        if self.imageFile == nil {
            finished = false
            
        }
        if userType == "CleanPerson" {
            if let county = countyDropDown.selectedItem {
                self.county = county
            } else {
                finished = false
                print("county fail")
            }
            
            if self.hourRateTextField.text == nil{
                finished = false
                print("hourRate fail")
            }
        }
        if finished {
            //spinner?
        
            let username = self.userNameTextField.text!
            let password = self.passwordTextField.text!
            let email = self.emailTextField.text!
            let finalEmail = email.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            let phoneNum = self.phoneNumberTextField.text!
            let newUser = PFUser()
            
            newUser.username = username
            newUser.password = password
            newUser.email = finalEmail
            newUser["userType"] = userType
            newUser["phoneNumber"] = phoneNum
            
            self.imageFile?.saveInBackground()
            if userType == "CleanPerson" {
                newUser["hourRate"] = self.hourRateTextField.text ?? ""
                newUser["introduction"] = self.introductionTextView.text ?? ""
                newUser["county"] = self.county ?? ""
                newUser["imageFile"] = self.imageFile
            }
            
            spinner.hidesWhenStopped = true
            spinner.center = view.center
            self.view.addSubview(spinner)
            spinner.startAnimating()
            
            // Sign up the user asynchronously
            newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                
                
                if ((error) != nil) {
                    print(error)
                    
                } else {
                    print("success")
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        if self.userType == "Customer" {
                            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CustomerTabBarController") as! UITabBarController
                            self.presentViewController(viewController, animated: true, completion: nil)
                        } else {
                            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CleanPersonTabBarController") as! UITabBarController
                            self.presentViewController(viewController, animated: true, completion: nil)
                        }

                        self.spinner.stopAnimating()
                        
                    })
                }
            })
            
            
        } else {
            self.spinner.stopAnimating()
            let alertController = UIAlertController(title: "Some Fields are not completed", message: "Please comlete text fields", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    
    }
    
    
    @IBOutlet weak var generalStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
//        self.introductionTextView.delegate = self
//        self.view.addSubview(introductionTextView)
        
        introductionTextView.textColor = UIColor.lightGrayColor()
        
        //keyboard avoiding test
  
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)

        
        
        self.setupChooseCountyDropDown()
        
        self.textFields = [self.userNameTextField, self.passwordTextField, self.emailTextField, self.phoneNumberTextField]
        
        self.countyButton?.hidden = true
        self.introductionTextView?.hidden = true
        self.hourRateTextField?.hidden = true
        
        // set our custom background image
        //        backgroundImage = UIImageView(image: UIImage(named: "welcome_bg"))
        //        backgroundImage.contentMode = UIViewContentMode.ScaleAspectFill
        //        signUpView!.insertSubview(backgroundImage, atIndex: 0)
        //

      //  self.hideKeyboardWhenTappedAround()
        
    }
/*
 
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupChooseCountyDropDown() {
        countyDropDown.anchorView = countyButton
        let appearance = DropDown.appearance()
        appearance.backgroundColor = UIColor.whiteColor()
        // Will set a custom with instead of anchor view width
        countyDropDown.width = 180
        
        // By default, the dropdown will have its origin on the top left corner of its anchor view
        // So it will come over the anchor view and hide it completely
        // If you want to have the dropdown underneath your anchor view, you can do this:
        countyDropDown.bottomOffset = CGPoint(x: 0, y: countyButton.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        countyDropDown.dataSource = [
            "Changhua County", "Chiayi City", "Chiayi County","Hsinchu City","Hsinchu County", "Hualien County", "Kaohsiung City", "Keelung City", "Kinmen County", "Lienchiang County", "Miaoli County", "Nantou County", "New Taipei City", "Penghu County", "Pingtung County", "Taichung City", "Tainan City", "Taipei City", "Taitung County", "Taoyuan City", "Yilan County", "Yunlin County"
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
    }

    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        subscribeToKeyboardNotifications()
       
    }

//    func dismissKeyboard() {
//        view.endEditing(true)
//    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:))    , name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide(_:))    , name: UIKeyboardWillHideNotification, object: nil)
        
//          self.topLayout.active = false
        
    }
    
    var bo: Bool = true
    func keyboardWillShow(notification: NSNotification) {
        let height = getKeyboardHeight(notification) - 40
        if bo {
            self.topLayout.active = false
            if self.topLayout == nil {
                print("nil")
            }
            view.frame.origin.y -= height
            bo = false
        }
    }
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    func keyboardWillHide(notification: NSNotification) {
        let height = getKeyboardHeight(notification) - 40
        if !bo {
            view.frame.origin.y += height
            self.topLayout.active = true
            bo = true
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    override func viewDidDisappear(animated: Bool) {
        unsubscribeFromKeyboardNotifications()
    }
    
    func unsubscribeFromKeyboardNotifications() {
        print("ttre")
     //   self.topLayout.active = true
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Introduce Yourself"
            textView.textColor = UIColor.lightGrayColor()
        }
    }
}



