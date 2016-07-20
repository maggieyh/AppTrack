//
//  SearchResultTableViewCell.swift
//  ChoreSolver
//
//  Created by yao  on 7/10/16.
//  Copyright © 2016 yao . All rights reserved.
//

import UIKit
import Bond
import Parse
class SearchResultTableViewCell: UITableViewCell {
    
    var requestDisposable: DisposableType?
    var imageDisposable: DisposableType?
    var customer: User?
//    var agree: Bool? {
//        didSet {
//            requestDisposable?.dispose()
//            if let agree = agree {
//                requestDisposable = requset.observe ({ (value: Bool?) in
//                    if let value = value {
//                        if value {
//                            
//                        } else {
//                            
//                        }
//                    } else {
//                        
//                    }
//                })
//            } else {
//                
//            }
//        }
//    }
    var requset: Observable<Request?> = Observable(nil)
    var cleanPerson: User? {
        didSet {
            imageDisposable?.dispose()
            //free memory of image stored with the CP that is no longer displayed
            if let oldValue = oldValue where oldValue != cleanPerson {
                oldValue.image.value = nil
            }
            if let cleanPerson = cleanPerson {
//                cleanPerson.image.bindTo(cleanPersonImage.bnd_image)
                imageDisposable = cleanPerson.image.bindTo(cleanPersonImage.bnd_image)
            }
        }
    }
    var tabBarViewController: UITabBarController?
    
    @IBOutlet weak var cleanPersonNameLabel: UILabel!
    @IBOutlet weak var cleanPersonImage: UIImageView!
    @IBOutlet weak var hourRateLabel: UILabel!

    @IBOutlet weak var requestButton: UIButton!
    
    @IBAction func requestInfoTapped(sender: AnyObject) {
        ParseHelper.initRequestInfo(PFUser.currentUser()!, cleanPerson: cleanPerson!, block: { (success: Bool, error: NSError?) in
            self.tabBarViewController!.selectedViewController = self.tabBarViewController!.viewControllers![1]
        })
        //transition to tab Request
        
        
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
