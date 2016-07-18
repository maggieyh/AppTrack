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

    var cleanPerson: PFUser?
    var agree: Bool?
    
    @IBOutlet weak var nameLabel: UILabel!
   
    @IBOutlet weak var hourRateLabel: UILabel!
    @IBOutlet weak var introductionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var introductionLabel: UILabel!
    @IBOutlet weak var contactMethodTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let cleanPerson = cleanPerson {
            
            if let imageFile = cleanPerson["imageFile"] as? PFFile {
                do {
                    let data = try imageFile.getData()
                    imageView.image = UIImage(data: data, scale: 1.0)
                } catch {
                    print("fail")
                }
            }
            
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
            if let agree = agree {
                if agree {
                    let email = cleanPerson.email! 
                    let phone = cleanPerson["phoneNumber"]! as! String
                    let str = "Email addresss: " + email + "\nPhone number: " + phone
                    contactMethodTextView.text = str
                } else {
                    contactMethodTextView.text = "Wait for \(nameLabel.text!)'s response"
                }
            } else {
                introductionLabel.hidden = true
                introductionTextView.hidden = true
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
