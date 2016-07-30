//
//  ReviewsTableViewCell.swift
//  ChoreSolver
//
//  Created by yao  on 7/30/16.
//  Copyright © 2016 yao . All rights reserved.
//

import UIKit
import Cosmos
class ReviewsTableViewCell: UITableViewCell {
    @IBOutlet weak var ratings: CosmosView!
    @IBOutlet weak var comment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
