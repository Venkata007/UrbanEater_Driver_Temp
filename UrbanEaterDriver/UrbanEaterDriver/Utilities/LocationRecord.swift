//
//  LocationRecord.swift
//  DriverReadyToEat
//
//  Created by Casperon iOS on 21/11/17.
//  Copyright © 2017 CasperonTechnologies. All rights reserved.
//

import UIKit

class LocationRecord: NSObject {

    var lattitude = "" , longitude = ""
    
    override init()
    {
        self.lattitude = ""
        self.longitude = ""
    }
    
    init(lattitude : String , longitude : String)
    {
        self.lattitude = lattitude
        self.longitude = longitude
    }
    
}
