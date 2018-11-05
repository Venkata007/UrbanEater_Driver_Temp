//
//  DriverModel.swift
//  UrbanEaterDriver
//
//  Created by Nagaraju on 05/11/18.
//  Copyright © 2018 Nagaraju. All rights reserved.
//

import UIKit
import SwiftyJSON

class DriverModel {
    
    var code : Int!
    var data : DriverData!
    var message : String!
    var name : String!
    var statusCode : Int!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        code = json["code"].int ?? 0
        let dataJson = json["data"]
        if !dataJson.isEmpty{
            data = DriverData(fromJson: dataJson)
        }
        message = json["message"].string ?? ""
        name = json["name"].string ?? ""
        statusCode = json["statusCode"].int ?? 0
    }
}

class DriverData {
    
    var ctdAt : String!
    var ctdOn : Int!
    var deviceToken : String!
    var id : String!
    var mobileId : String!
    var role : String!
    var sessionId : String!
    var through : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        ctdAt = json["ctdAt"].string ?? ""
        ctdOn = json["ctdOn"].int ?? 0
        deviceToken = json["deviceToken"].string ?? ""
        id = json["id"].string ?? ""
        mobileId = json["mobileId"].string ?? ""
        role = json["role"].string ?? ""
        sessionId = json["sessionId"].string ?? ""
        through = json["through"].string ?? ""
    }
    
}
