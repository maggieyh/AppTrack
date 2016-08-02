//
//  sentRequestTableViewCell.swift
//  ChoreSolver
//
//  Created by yao  on 7/11/16.
//  Copyright © 2016 yao . All rights reserved.
//

import UIKit
import Parse
import Bond
import ConvenienceKit
class sentRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var stateImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cleanPersonImage: UIImageView!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var hourRateLabel: UILabel!
    var imageDisposable: DisposableType?
    var cleanPerson: User? {
        didSet {
            imageDisposable?.dispose()
            if let oldValue = oldValue where oldValue != cleanPerson {
                oldValue.image.value = nil
            }
            if let cleanPerson = cleanPerson {
                imageDisposable = cleanPerson.image.bindTo(cleanPersonImage.bnd_image)
            }
        }
    }
    var request: Request?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
