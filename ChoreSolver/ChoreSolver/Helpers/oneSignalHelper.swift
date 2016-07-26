//
//  oneSignalHelper.swift
//  ChoreSolver
//
//  Created by yao  on 7/26/16.
//  Copyright © 2016 yao . All rights reserved.
//

import Foundation
import Parse
class oneSignalHelper {
    var oneSignal: OneSignal?
    init(oneSignal: OneSignal) {
        self.oneSignal = oneSignal
    }
    func setObjectID(user: PFUser) {
       self.oneSignal?.sendTag("objectId", value: user.objectId!)
    }
    func sendNotification(user: PFUser) {
        
    }
}