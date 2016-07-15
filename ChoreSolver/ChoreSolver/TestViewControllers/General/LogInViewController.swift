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
                    print("successfully log in")
                } else {
                    // The login failed. Check error to see why.
                    print("ah!!!")
                }
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

}
