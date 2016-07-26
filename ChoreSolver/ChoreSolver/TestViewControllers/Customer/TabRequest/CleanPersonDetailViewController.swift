//
//  CleanPersonDetailViewController.swift
//  ChoreSolver
//
//  Created by yao  on 7/16/16.
//  Copyright © 2016 yao . All rights reserved.
//

import UIKit
import Parse
class CleanPersonDetailViewController: UIViewController {
    var fromRequestView: Bool?
    var cleanPerson: User?
    var agree: Bool?
    var stateOfRequest: Int?
    
    @IBOutlet weak var navigationBarItem: UINavigationItem!
    @IBOutlet weak var nameLabel: UILabel!
   
    @IBOutlet weak var contactLabel: UILabel!
    
    @IBOutlet weak var hourRateLabel: UILabel!
    @IBOutlet weak var introductionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var introductionLabel: UILabel!
    @IBOutlet weak var contactMethodTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let cleanPerson = cleanPerson {
            cleanPerson.downloadImage()
            imageView.image = cleanPerson.image.value
            nameLabel.text = cleanPerson.username
            
            if let hourRate = cleanPerson["hourRate"] as? String {
                hourRateLabel.text = hourRate + "$/hr"
            } else {
                hourRateLabel.text = ""
            }
            if let intro = cleanPerson["introduction"] as? String {
                introductionTextView.text = intro
            } else {
                introductionTextView.text = ""
            }
            
            if let value = stateOfRequest {
                switch(value){
                case 1:
                    //agree
                    let email = cleanPerson.email!
                    let phone = cleanPerson["phoneNumber"]! as! String
                    let str = "Email addresss: " + email + "\nPhone number: " + phone
                    contactMethodTextView.text = str
                case 2:
                    //not yet respond
                    contactMethodTextView.text = "Wait for \(nameLabel.text!)'s response"
                default:
                    contactMethodTextView.hidden = true
                    contactLabel.hidden = true
                }
            } else {
                contactMethodTextView.hidden = true
                contactLabel.hidden = true
            }

        }
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
