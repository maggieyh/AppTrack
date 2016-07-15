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


class RegisterViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    let countyDropDown = DropDown()
    
    let customerData = ["Name", "Email", "Phone Number"]
    let cleanPersonData = ["Name", "Email", "Phone Number","Hour Rate" ]
    var userType: String = "Customer"
    
    
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var hourRateTextField: UITextField!
    @IBOutlet weak var introductionTextView: UITextView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var hourRateLabel: UILabel!
    @IBOutlet weak var introductionLabel: UILabel!
    
    @IBAction func doneTapped(sender: AnyObject) {
        if userType == "Customer" {
            let viewController = storyboard?.instantiateViewControllerWithIdentifier("CleanPersonTabBarController")
            self.presentViewController(viewController!, animated: true, completion: nil)
        } else {
            let viewController = storyboard?.instantiateViewControllerWithIdentifier("CustomerTabBarController")
            self.presentViewController(viewController!, animated: true, completion: nil)
        }
    }
    @IBOutlet weak var countyButton: UIButton!
    
    @IBAction func chooseCounty(sender: AnyObject) {
        countyDropDown.show()
    }

    
    @IBAction func userTypeToggled(sender: AnyObject) {
        if userType == "CleanPerson" {
            userType = "Customer"
        } else {
            userType = "CleanPerson"
        }
    }
    //MARK: customer
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupChooseCountyDropDown()
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
    
    func setupChooseCountyDropDown() {
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
    }

}



