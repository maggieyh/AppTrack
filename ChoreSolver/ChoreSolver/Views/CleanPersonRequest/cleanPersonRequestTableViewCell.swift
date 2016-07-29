//
//  cleanPersonRequestTableViewCell.swift
//  ChoreSolver
//
//  Created by yao  on 7/12/16.
//  Copyright © 2016 yao . All rights reserved.
//

import UIKit
import Parse
import Bond
protocol tableViewCellNotificationDelegate {
    func presentViewController(alertController: UIAlertController, indexPath: NSIndexPath)
}
class cleanPersonRequestTableViewCell: UITableViewCell {
    var imageDisposable: DisposableType?
    var indexPath: NSIndexPath?
    var customer: User? {
        didSet {
            imageDisposable?.dispose()
            if let customer = customer {
                imageDisposable = customer.image.bindTo(customerImageView.bnd_image)
            }
        }
    }
    var request: Request?
    var delegate: tableViewCellNotificationDelegate?
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var customerImageView: UIImageView!
    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var requestStateLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBAction func replyButtonTapped(sender: AnyObject) {
        trailingConstraint.constant = 0
        self.replyButton.hidden = true
        self.request?.agree = NSNumber(bool: true)
        self.request?.saveInBackground()
        
        let alertController: UIAlertController = UIAlertController(title: "Send a message", message: "Anything you want to tell", preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler(nil)
        var message: UITextField?
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction) in
                message = (alertController.textFields?.first)!
                if message!.text == nil {
                    message!.text = ""
                }
        
                let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
                
                if let customerOneSignalID = self.customer!.oneSignalID as? String {
                    let jsonData = ["app_id": "6f185136-e88e-4421-84b2-f8e681c0da7e","include_player_ids": [customerOneSignalID],"contents": ["en": "You recieved \(PFUser.currentUser()!.username!)'s info. Contact each other !!\n\(message!.text!)"]]
                    
                    appDelegate!.oneSignal!.postNotification(jsonData)
                }
            
         }))
        
        self.delegate?.presentViewController(alertController, indexPath: self.indexPath!)
        
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
