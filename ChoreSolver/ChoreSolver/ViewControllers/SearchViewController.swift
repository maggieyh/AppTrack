//
//  SearchViewController.swift
//  ChoreSolver
//
//  Created by yao  on 7/9/16.
//  Copyright © 2016 yao . All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBAction func buttonTapped(sender: AnyObject) {
       // self.performSegueWithIdentifier("showResult", sender: sender)
//        let mainStoryboard = UIStoryboard(name: "searchViewController", bundle: NSBundle.mainBundle())
//        let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("searchResultViewController") as UIViewController
//    
//        self.presentViewController(vc, animated: true, completion: nil)
    }
    
  //  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "showResult" {
//            segue.destinationViewController.tabBarController = self.tabBarController
//        }
//    }
    override func unwindForSegue(unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        
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
