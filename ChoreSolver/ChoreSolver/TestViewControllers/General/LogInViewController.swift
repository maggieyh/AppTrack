//
//  LogInViewController.swift
//  ChoreSolver
//
//  Created by yao  on 7/15/16.
//  Copyright © 2016 yao . All rights reserved.
//

import UIKit
import ParseUI
import Parse


class LogInViewController: UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LogInViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    func dismissKeyboard() {
        self.view.endEditing(true)
       
    }
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBAction func logInTapped(sender: AnyObject) {
        if userNameTextField.text == nil || passwordTextField.text == nil {
            print("try again")
        } else {
            PFUser.logInWithUsernameInBackground(userNameTextField.text!, password:passwordTextField.text!) {
                (user: PFUser?, error: NSError?) -> Void in
                if user != nil {
                    // Do stuff after successful login.
                    if error != nil {
                        return
                    }
                    if user!["userType"] as? String == "Customer" {
                        print("cusotmer")
                        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CustomerTabBarController") as! UITabBarController
                        self.presentViewController(viewController, animated: true, completion: nil)
                    } else {
                        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CleanPersonTabBarController") as! UITabBarController
                        self.presentViewController(viewController, animated: true, completion: nil)
                        
                    }

                } else {
                    // The login failed. Check error to see why.
                    print("ah!!!")
                }
            }
        }
        
    }
    @IBAction func unwindBackToLogInView(segue:UIStoryboardSegue) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
//        customizeButton(self.logInButton)
        customizeButton(self.signUpButton)
        
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
    func customizeButton(button: UIButton!) {
        button.setBackgroundImage(nil, forState: .Normal)
        button.backgroundColor = UIColor.clearColor()
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.whiteColor().CGColor
    }
}
