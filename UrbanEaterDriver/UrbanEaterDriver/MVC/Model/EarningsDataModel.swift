//
//	EarningsDataModel.swift
//
//	Create by Vamsi Gonaboyina on 20/12/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON

class EarningsDataModel{

	var code : Int!
	var data : EarningsDataData!
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
			data = EarningsDataData(fromJson: dataJson)
		}
		message = json["message"].string ?? ""
		name = json["name"].string ?? ""
		statusCode = json["statusCode"].int ?? 0
	}

}

class EarningsDataData{
    
    var earningData : [EarningsDataEarningData]!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        earningData = [EarningsDataEarningData]()
        let earningDataArray = json["earningData"].arrayValue
        for earningDataJson in earningDataArray{
            let value = EarningsDataEarningData(fromJson: earningDataJson)
            earningData.append(value)
        }
    }
    
}

class EarningsDataEarningData{
    
    var driverId : String!
    var totalEarnAmount : Int!
    var totalOrderCount : Int!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        driverId = json["driverId"].string ?? ""
        totalEarnAmount = json["totalEarnAmount"].int ?? 0
        totalOrderCount = json["totalOrderCount"].int ?? 0
    }
    
}
