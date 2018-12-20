//
//	DriverHomeModel.swift
//
//	Create by Vamsi Gonaboyina on 19/12/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON

class DriverHomeModel{

	var code : Int!
	var data : DriverHomeData!
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
			data = DriverHomeData(fromJson: dataJson)
		}
		message = json["message"].string ?? ""
		name = json["name"].string ?? ""
		statusCode = json["statusCode"].int ?? 0
	}

}

class DriverHomeBankDetail{
    
    var iFSC : String!
    var accountNumber : String!
    var name : String!
    var routingNumber : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        iFSC = json["IFSC"].string ?? ""
        accountNumber = json["accountNumber"].string ?? ""
        name = json["name"].string ?? ""
        routingNumber = json["routingNumber"].string ?? ""
    }
    
}

class DriverHomeData{
    
    var available : Int!
    var avatar : String!
    var bankDetails : DriverHomeBankDetail!
    var cityId : String!
    var cityName : String!
    var code : String!
    var currentJob : Int!
    var currentStatus : Int!
    var deviceInfo : DriverHomeDeviceInfo!
    var earningIdData : [DriverHomeEarningIdData]!
    var earningType : String!
    var emailId : String!
    var id : String!
    var licence : DriverHomeLicence!
    var mobileId : String!
    var name : String!
    var statIdData : DriverHomeStatIdData!
    var status : Int!
    var through : String!
    var uniqueId : String!
    var vehicleType : String!
    var verified : Int!
    var verifiedEmail : Int!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        available = json["available"].int ?? 0
        avatar = json["avatar"].string ?? ""
        let bankDetailsJson = json["bankDetails"]
        if !bankDetailsJson.isEmpty{
            bankDetails = DriverHomeBankDetail(fromJson: bankDetailsJson)
        }
        cityId = json["cityId"].string ?? ""
        cityName = json["cityName"].string ?? ""
        code = json["code"].string ?? ""
        currentJob = json["currentJob"].int ?? 0
        currentStatus = json["currentStatus"].int ?? 0
        let deviceInfoJson = json["deviceInfo"]
        if !deviceInfoJson.isEmpty{
            deviceInfo = DriverHomeDeviceInfo(fromJson: deviceInfoJson)
        }
        earningIdData = [DriverHomeEarningIdData]()
        let earningIdDataArray = json["earningIdData"].arrayValue
        for earningIdDataJson in earningIdDataArray{
            let value = DriverHomeEarningIdData(fromJson: earningIdDataJson)
            earningIdData.append(value)
        }
        earningType = json["earningType"].string ?? ""
        emailId = json["emailId"].string ?? ""
        id = json["id"].string ?? ""
        let licenceJson = json["licence"]
        if !licenceJson.isEmpty{
            licence = DriverHomeLicence(fromJson: licenceJson)
        }
        mobileId = json["mobileId"].string ?? ""
        name = json["name"].string ?? ""
        let statIdDataJson = json["statIdData"]
        if !statIdDataJson.isEmpty{
            statIdData = DriverHomeStatIdData(fromJson: statIdDataJson)
        }
        status = json["status"].int ?? 0
        through = json["through"].string ?? ""
        uniqueId = json["uniqueId"].string ?? ""
        vehicleType = json["vehicleType"].string ?? ""
        verified = json["verified"].int ?? 0
        verifiedEmail = json["verifiedEmail"].int ?? 0
    }
    
}

class DriverHomeDeviceInfo{
    
    var deviceId : String!
    var deviceToken : String!
    var os : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        deviceId = json["deviceId"].string ?? ""
        deviceToken = json["deviceToken"].string ?? ""
        os = json["os"].string ?? ""
    }
    
}

class DriverHomeEarningIdData{
    
    var billingStatus : Int!
    var date : Int!
    var dateString : String!
    var driverId : String!
    var earnAmount : Int!
    var id : String!
    var orderCount : Int!
    var orderId : [String]!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        billingStatus = json["billingStatus"].int ?? 0
        date = json["date"].int ?? 0
        dateString = json["dateString"].string ?? ""
        driverId = json["driverId"].string ?? ""
        earnAmount = json["earnAmount"].int ?? 0
        id = json["id"].string ?? ""
        orderCount = json["orderCount"].int ?? 0
        orderId = [String]()
        let orderIdArray = json["orderId"].arrayValue
        for orderIdJson in orderIdArray{
            orderId.append(orderIdJson.string ?? "")
        }
    }
    
}

class DriverHomeLicence{
    
    var number : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        number = json["number"].string ?? ""
    }
    
}

class DriverHomeOrder{
    
    var accepted : Int!
    var cancelled : Int!
    var delivered : Int!
    var rejected : Int!
    var sent : Int!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        accepted = json["accepted"].int ?? 0
        cancelled = json["cancelled"].int ?? 0
        delivered = json["delivered"].int ?? 0
        rejected = json["rejected"].int ?? 0
        sent = json["sent"].int ?? 0
    }
    
}

class DriverHomeRating{
    
    var average : Float!
    var totalCount : Int!
    var totalValue : Float!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        average = json["average"].float ?? 0.0
        totalCount = json["totalCount"].int ?? 0
        totalValue = json["totalValue"].float ?? 0.0
    }
    
}

class DriverHomeStatIdData{
    
    var driverId : String!
    var id : String!
    var order : DriverHomeOrder!
    var rating : DriverHomeRating!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        driverId = json["driverId"].string ?? ""
        id = json["id"].string ?? ""
        let orderJson = json["order"]
        if !orderJson.isEmpty{
            order = DriverHomeOrder(fromJson: orderJson)
        }
        let ratingJson = json["rating"]
        if !ratingJson.isEmpty{
            rating = DriverHomeRating(fromJson: ratingJson)
        }
    }
    
}

