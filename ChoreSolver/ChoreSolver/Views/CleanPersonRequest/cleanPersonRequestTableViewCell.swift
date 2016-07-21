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
class cleanPersonRequestTableViewCell: UITableViewCell {
    var imageDisposable: DisposableType?
    var customer: User? {
        didSet {
            imageDisposable?.dispose()
            if let customer = customer {
                imageDisposable = customer.image.bindTo(customerImageView.bnd_image)
            }
        }
    }
    var request: Request?
    
    @IBOutlet weak var customerImageView: UIImageView!
    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var requestStateLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBAction func replyButtonTapped(sender: AnyObject) {
        self.replyButton.hidden = true
        let query = PFQuery(className:"Request")
        query.getObjectInBackgroundWithId(request!.objectId!) {
            (request: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            }
            if let request = request as? Request {
                request.agree = NSNumber(bool: true)
                request.saveInBackground()
            }
        }
        
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
