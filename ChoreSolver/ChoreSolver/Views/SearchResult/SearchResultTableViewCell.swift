//
//  SearchResultTableViewCell.swift
//  ChoreSolver
//
//  Created by yao  on 7/10/16.
//  Copyright © 2016 yao . All rights reserved.
//

import UIKit
import Parse
class SearchResultTableViewCell: UITableViewCell {

    var cleanPerson: PFUser?
    var viewController: UIViewController?
    
    @IBOutlet weak var cleanPersonNameLabel: UILabel!
    @IBOutlet weak var cleanPersonImage: UIImageView!
    @IBOutlet weak var hourRateLabel: UILabel!

    @IBAction func requestInfoTapped(sender: AnyObject) {
        ParseHelper.initRequestInfo(PFUser.currentUser()!, cleanPerson: cleanPerson!)
        //self.tabBarController!.selectedViewController = self.tabBarController!.viewControllers![1]
        //self.viewController?.presentViewController(RequestViewController, animated: true, completion: nil)
        
    }
    
    //func transition(Sender: UIButton!) {
      //  let secondViewController:SecondViewController = SecondViewController()
        
      //  self.presentViewController(secondViewController, animated: true, completion: nil)
        
    //}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
}
