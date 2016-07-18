//
//  AppDelegate.swift
//  ChoreSolver
//
//  Created by yao  on 7/9/16.
//  Copyright © 2016 yao . All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import ParseUI
import ParseFacebookUtilsV4
import DropDown
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
//    var parseLoginHelper: ParseLoginHelper!

    override init() {
        super.init()
        
//        parseLoginHelper = ParseLoginHelper {[unowned self] user, error in
//            //initializa the ParseLoginHelper with a callback
//            if let error = error {
//                //1
//                ErrorHandling.defaultErrorHandler(error)
//            } else if let _ = user {
//                
//                //if login was successful, display the TabBarConTroller
//               /* //2 load storyboard and view controller manually
////                let storyboard = UIStoryboard(name: "Main", bundle: nil)
////                let tabBarController = storyboard.instantiateViewControllerWithIdentifier("CustomerTabBarController") as! UITabBarController
////                //3 choose the main view controller of our app, in code, by setting the rootViewController property of the AppDelegate's window
////                self.window?.rootViewController!.presentViewController(tabBarController, animated: true, completion: nil)*/
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
//                let tabBarController = storyboard.instantiateViewControllerWithIdentifier("CustomerTabBarController") as! UITabBarController
//                self.window?.rootViewController = tabBarController
//                self.window?.makeKeyAndVisible()
//                
//            }
//        }
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //set up drop down
        DropDown.startListeningToKeyboard()
        
        // Set up the Parse SDK
        let configuration = ParseClientConfiguration {
            $0.applicationId = "CleanSolver"
            $0.server = "https://cleansolver-parse-yh.herokuapp.com/parse"
        }
        Parse.initializeWithConfiguration(configuration)
        
       
//         Set up fake testCustomer login
//        do {
////            try PFUser.logInWithUsername("testCustomer", password: "testCustomer")
//            try PFUser.logInWithUsername("testCleanPerson", password: "testCleanPerson")
//
//        } catch {
//            print("Unable to log in")
//        }
//        
//        if let currentUser = PFUser.currentUser() {
//            print("\(currentUser.username!) logged in successfully")
//        } else {
//            print("No logged in user :(")
//        }
//    

        
       
        // Initialize Facebook
       
//        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
        
        // check if we have logged in user
        let user = PFUser.currentUser()
        var startViewController: UIViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if (user != nil) {

            do {
                let user = try PFUser.currentUser()!.fetch()
                if user["userType"] as? String == "Customer" {
                    print("cusotmer")
                    startViewController = storyboard.instantiateViewControllerWithIdentifier("CustomerTabBarController") as! UITabBarController
                    
                } else {
                    print("cleanPErson")
                    startViewController = storyboard.instantiateViewControllerWithIdentifier("CleanPersonTabBarController") as! UITabBarController
                }
            } catch {
                startViewController = storyboard.instantiateViewControllerWithIdentifier("CustomerTabBarController") as! UITabBarController
                print("fail in switch")
            }
            
        } else {
        
//            let loginViewController = PFLogInViewController()
////            let loginViewController = FBloginhelperViewController()
////            loginViewController.facebookPermissions = ["public_profile", "email"]
//            
//            let signUpViewController = storyboard.instantiateViewControllerWithIdentifier("signUpViewController") as! RegisterViewController
//            loginViewController.fields = [.UsernameAndPassword, .LogInButton, .SignUpButton, .PasswordForgotten]
//            loginViewController.delegate = parseLoginHelper
//            loginViewController.signUpController = signUpViewController
//            //loginViewController.signUpController?.delegate = parseLoginHelper
//           
//            startViewController = loginViewController
            
            startViewController = storyboard.instantiateViewControllerWithIdentifier("logInViewController")
        }
        
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = startViewController;
        self.window?.makeKeyAndVisible()
        
//        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)

        return true
    }

    //MARK: Facebook Integration
    
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

