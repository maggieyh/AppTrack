//
//  cleanPersonProfileEditingViewController.swift
//  ChoreSolver
//
//  Created by yao  on 7/18/16.
//  Copyright © 2016 yao . All rights reserved.
//

import UIKit
import Parse
import DropDown
import Bond
class CleanPersonProfileEditingViewController: UIViewController {

    
    @IBOutlet var topLayout: NSLayoutConstraint!
    var county: String?
    var imageFile: PFFile?
    var image: Observable<UIImage?> = Observable(nil)
    var bo: Bool = true
    
    var photoTakingHelper: PhotoTakingHelper?
    let countyDropDown = DropDown()
    var textFields: [UITextField!]?
    var user: PFUser?
    
    
    var doubleTapped: Bool = true
    func state(bool: Bool) {
        self.chooseImageButton.enabled = bool
        for ele in textFields! {
            ele.enabled = bool
        }
        self.introductionTextView.editable = bool
        self.chooseCountyButton.enabled = bool
    }
    func update() {
        self.user!.email = self.emailTextFiled.text!
        self.user!["phoneNumber"] = self.phoneNumberTextField.text!
        self.user!["hourRate"] = self.hourRateTextField.text!
        self.user!["introduction"] = self.introductionTextView.text!
        if let newCounty = countyDropDown.selectedItem {
            self.user!["county"] = newCounty
        }
        
        self.user!.saveInBackground()
        
    }
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBAction func editButtonTapped(sender: AnyObject) {
        if doubleTapped {
            self.state(true)
            
            editBarButton.title = "Update"
            doubleTapped = false
        } else {
            self.state(false)
            self.update()
            editBarButton.title = "Edit"
            doubleTapped = true
    
        }
    }
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var chooseImageButton: UIButton!
    @IBAction func chooseImageButtonTapped(sender: AnyObject) {
        photoTakingHelper = PhotoTakingHelper(viewController: self) { (image: UIImage?) in
            //turn the UIImage into an NSData instance because the PFFile class needs an NSData argument for its initializer.
            if let image = image {
                self.imageView.image = image
                guard let data = UIImagePNGRepresentation(image) else { print("ff"); return}
                let user = PFUser.currentUser()!
//                user.setValue(PFFile(name: "\(user.username)\(user.email!).jpg", data: data!), forKey: "imageFile")
                
                user.setValue(PFFile(name: "anotheer.jpg", data: data), forKey: "imageFile")
                user.saveInBackground()
                
            }
            
        }
    }
    var keyboard: Bool? = false
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var hourRateTextField: UITextField!
    @IBOutlet weak var introductionTextView: UITextView!
    
    @IBOutlet weak var chooseCountyButton: UIButton!
    @IBAction func chooseCountyTapped(sender: AnyObject) {
        countyDropDown.show()
        //update change in edit button tapped again
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.image.bindTo(self.imageView.bnd_image)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.introductionTextView.delegate = self
        self.user = PFUser.currentUser()!
        self.userNameTextField.text = self.user!.username!
        self.userNameTextField.enabled = false
        
        self.emailTextFiled.text = self.user!.email
        self.phoneNumberTextField.text = self.user!["phoneNumber"] as? String
        self.hourRateTextField.text = self.user!["hourRate"] as? String
        self.introductionTextView.text = self.user!["introduction"] as? String
        
        self.setupChooseCountyDropDown()
        
        self.chooseCountyButton.setTitle(self.user!["county"] as? String, forState: .Normal)
        
        
        
        self.imageFile = self.user!["imageFile"] as? PFFile
        
        self.downloadImage()
//
//        do {
//            let data = try imageFile!.getData()
//            self.imageView.image = UIImage(data: data, scale: 1.0)
//        } catch {
//            print("fail")
//        }
        
        self.textFields = [self.emailTextFiled, self.phoneNumberTextField, self.hourRateTextField]
        self.state(false)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupChooseCountyDropDown() {
        countyDropDown.anchorView = chooseCountyButton
        let appearance = DropDown.appearance()
        appearance.backgroundColor = UIColor.whiteColor()
        // Will set a custom with instead of anchor view width
        countyDropDown.width = 180
        
        // By default, the dropdown will have its origin on the top left corner of its anchor view
        // So it will come over the anchor view and hide it completely
        // If you want to have the dropdown underneath your anchor view, you can do this:
        countyDropDown.bottomOffset = CGPoint(x: 0, y: chooseCountyButton.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        countyDropDown.dataSource = Data.counties
        // Action triggered on selection
        countyDropDown.selectionAction = { [unowned self] (index, item) in
            self.chooseCountyButton.setTitle(item, forState: .Normal)
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
    func downloadImage() {
        // if image is not downloaded yet, get it
        // 1
        if (image.value == nil) {
            // 2
            imageFile?.getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) -> Void in
                if let data = data {
                    let image = UIImage(data: data, scale:1.0)!
                    // 3
                    self.image.value = image
                    self.imageView.image = self.image.value
                }
            }
        }
    }
}

extension CleanPersonProfileEditingViewController {
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
    
    
    func keyboardWillShow(notification: NSNotification) {
        if self.keyboard! == false { return }
        let height = getKeyboardHeight(notification) - 50

        if bo {
           // NSLayoutConstraint.deactivateConstraints([self.topLayout])
            self.topLayout.active = false
            if self.topLayout == nil {
                print("laternil")
            }
            view.frame.origin.y -= height
            bo = false
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if self.keyboard! == false { return }
        let height = getKeyboardHeight(notification) - 50
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
        self.topLayout.active = true
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
}

extension CleanPersonProfileEditingViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
       
        self.keyboard = true
        return true
    }

    func textViewDidEndEditing(textView: UITextView) {
        
        self.keyboard = false
        
    }
}