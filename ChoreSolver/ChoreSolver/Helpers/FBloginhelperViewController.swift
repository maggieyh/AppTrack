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
class FBloginhelperViewController: PFLogInViewController {
    var loginButton:FBSDKLoginButton?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.loginButton = FBSDKLoginButton()
        self.view.addSubview(loginButton!)
        loginButton!.center = self.view.center
        loginButton!.readPermissions = ["public_profile", "email", "user_friends"]
        self.facebookPermissions = ["public_profile", "email", "user_friends"]

        loginButton?.addTarget(self, action: nil, forControlEvents: .TouchDown)
     //   self.view.
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
