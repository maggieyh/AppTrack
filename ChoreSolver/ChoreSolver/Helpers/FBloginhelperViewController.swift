//
//  FBloginhelperViewController.swift
//  ChoreSolver
//
//  Created by yao  on 7/13/16.
//  Copyright © 2016 yao . All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import ParseUI
import ParseFacebookUtilsV4
class FBloginhelperViewController: PFLogInViewController, FBSDKLoginButtonDelegate {
    //var loginButton:FBSDKLoginButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("aloginbutton")
        let loginButton = FBSDKLoginButton()
        loginButton.center = self.view.center
        loginButton.delegate = self
        self.view.addSubview(loginButton)
//        loginButton!.readPermissions = ["public_profile", "email", "user_friends"]
//        self.facebookPermissions = ["public_profile", "email", "user_friends"]
//
//        loginButton?.addTarget(self, action: nil, forControlEvents: .TouchDown)
     //   self.view.
    }
    //MARK: FBSDKLoginButtonDelegate
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        /*
         Check for successful login and act accordingly.
         Perform your segue to another UIViewController here.
         */
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewControllerWithIdentifier("CleanPersonTabBarController")
        print("ahahahaha")
        self.presentViewController(tabBarController, animated:true, completion:nil)
        
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        // Actions for when the user logged out goes here
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
