//
//  GlobalModel.swift
//  DinedooRestaurant
//
//  Created by Nagaraju on 02/11/18.
//  Copyright © 2018 casperonIOS. All rights reserved.
//

import Foundation

let GlobalClass = GlobalModel.sharedInstance

class GlobalModel:NSObject {
    
    static let sharedInstance = GlobalModel()
    var driverModel:DriverModel!
    var earningModel: EarningModel!
    var notificationModel: NotofocationModel!
    
    override init() {
        super.init()
    }
}
