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
    var tabBarController: UITabBarController?
    
    @IBOutlet weak var cleanPersonNameLabel: UILabel!
    @IBOutlet weak var cleanPersonImage: UIImageView!

    @IBAction func requestInfoTapped(sender: AnyObject) {
        ParseHelper.initRequestInfo(PFUser.currentUser()!, cleanPerson: cleanPerson!)
        self.tabBarController!.selectedViewController = self.tabBarController!.viewControllers![1]
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
}
