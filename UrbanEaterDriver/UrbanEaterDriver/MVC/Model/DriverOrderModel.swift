//
//	DriverOrderModel.swift
//
//	Create by Vamsi Gonaboyina on 19/12/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON

class DriverOrderModel{

	var code : Int!
	var data : [DriverOrderData]!
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
		data = [DriverOrderData]()
		let dataArray = json["data"].arrayValue
		for dataJson in dataArray{
			let value = DriverOrderData(fromJson: dataJson)
			data.append(value)
		}
		message = json["message"].string ?? ""
		name = json["name"].string ?? ""
		statusCode = json["statusCode"].int ?? 0
	}

}

class DriverOrderAddon{
    
    var addonId : String!
    var finalPrice : Int!
    var name : String!
    var price : Int!
    var quantity : Int!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        addonId = json["addonId"].string ?? ""
        finalPrice = json["finalPrice"].int ?? 0
        name = json["name"].string ?? ""
        price = json["price"].int ?? 0
        quantity = json["quantity"].int ?? 0
    }
    
}

class DriverOrderAddres{
    
    var city : String!
    var country : String!
    var fulladdress : String!
    var line1 : String!
    var line2 : String!
    var state : String!
    var zipcode : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        city = json["city"].string ?? ""
        country = json["country"].string ?? ""
        fulladdress = json["fulladdress"].string ?? ""
        line1 = json["line1"].string ?? ""
        line2 = json["line2"].string ?? ""
        state = json["state"].string ?? ""
        zipcode = json["zipcode"].string ?? ""
    }
    
}

class DriverOrderBilling{
    
    var couponDiscount : Int!
    var deliveryCharge : Int!
    var grandTotal : Float!
    var orderTotal : Int!
    var serviceTax : Int!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        couponDiscount = json["couponDiscount"].int ?? 0
        deliveryCharge = json["deliveryCharge"].int ?? 0
        grandTotal = json["grandTotal"].float ?? 0.0
        orderTotal = json["orderTotal"].int ?? 0
        serviceTax = json["serviceTax"].int ?? 0
    }
    
}

class DriverOrderCustomize{
    
    var customizeId : String!
    var name : String!
    var price : Int!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        customizeId = json["customizeId"].string ?? ""
        name = json["name"].string ?? ""
        price = json["price"].int ?? 0
    }
    
}

class DriverOrderData{
    
    var addons : [DriverOrderAddon]!
    var address : DriverOrderAddres!
    var billing : DriverOrderBilling!
    var code : Int!
    var ctdAt : String!
    var customerId : String!
    var discounts : DriverOrderDiscount!
    var driverId : String!
    var history : DriverOrderHistory!
    var id : String!
    var items : [DriverOrderItem]!
    var loc : DriverOrderLoc!
    var order : [DriverOrderOrder]!
    var orderAddressId : String!
    var orderDate : String!
    var orderId : String!
    var orderOn : Int!
    var payment : DriverOrderPayment!
    var ratingStatus : Int!
    var restaurantId : [String]!
    var restaurantIdData : [DriverOrderRestaurantIdData]!
    var status : Int!
    var statusText : String!
    var transactionId : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        addons = [DriverOrderAddon]()
        let addonsArray = json["addons"].arrayValue
        for addonsJson in addonsArray{
            let value = DriverOrderAddon(fromJson: addonsJson)
            addons.append(value)
        }
        let addressJson = json["address"]
        if !addressJson.isEmpty{
            address = DriverOrderAddres(fromJson: addressJson)
        }
        let billingJson = json["billing"]
        if !billingJson.isEmpty{
            billing = DriverOrderBilling(fromJson: billingJson)
        }
        code = json["code"].int ?? 0
        ctdAt = json["ctdAt"].string ?? ""
        customerId = json["customerId"].string ?? ""
        let discountsJson = json["discounts"]
        if !discountsJson.isEmpty{
            discounts = DriverOrderDiscount(fromJson: discountsJson)
        }
        driverId = json["driverId"].string ?? ""
        let historyJson = json["history"]
        if !historyJson.isEmpty{
            history = DriverOrderHistory(fromJson: historyJson)
        }
        id = json["id"].string ?? ""
        items = [DriverOrderItem]()
        let itemsArray = json["items"].arrayValue
        for itemsJson in itemsArray{
            let value = DriverOrderItem(fromJson: itemsJson)
            items.append(value)
        }
        let locJson = json["loc"]
        if !locJson.isEmpty{
            loc = DriverOrderLoc(fromJson: locJson)
        }
        order = [DriverOrderOrder]()
        let orderArray = json["order"].arrayValue
        for orderJson in orderArray{
            let value = DriverOrderOrder(fromJson: orderJson)
            order.append(value)
        }
        orderAddressId = json["orderAddressId"].string ?? ""
        orderDate = json["orderDate"].string ?? ""
        orderId = json["orderId"].string ?? ""
        orderOn = json["orderOn"].int ?? 0
        let paymentJson = json["payment"]
        if !paymentJson.isEmpty{
            payment = DriverOrderPayment(fromJson: paymentJson)
        }
        ratingStatus = json["ratingStatus"].int ?? 0
        restaurantId = [String]()
        let restaurantIdArray = json["restaurantId"].arrayValue
        for restaurantIdJson in restaurantIdArray{
            restaurantId.append(restaurantIdJson.string ?? "")
        }
        restaurantIdData = [DriverOrderRestaurantIdData]()
        let restaurantIdDataArray = json["restaurantIdData"].arrayValue
        for restaurantIdDataJson in restaurantIdDataArray{
            let value = DriverOrderRestaurantIdData(fromJson: restaurantIdDataJson)
            restaurantIdData.append(value)
        }
        status = json["status"].int ?? 0
        statusText = json["statusText"].string ?? ""
        transactionId = json["transactionId"].string ?? ""
    }
    
}

class DriverOrderDiscount{
    
    var couponId : String!
    var offerId : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        couponId = json["couponId"].string ?? ""
        offerId = json["offerId"].string ?? ""
    }
    
}

class DriverOrderHistory{
    
    var acceptedAt : String!
    var allocatedAt : String!
    var deliveredAt : String!
    var orderedAt : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        acceptedAt = json["acceptedAt"].string ?? ""
        allocatedAt = json["allocatedAt"].string ?? ""
        deliveredAt = json["deliveredAt"].string ?? ""
        orderedAt = json["orderedAt"].string ?? ""
    }
    
}

class DriverOrderItem{
    
    var customize : DriverOrderCustomize!
    var finalPrice : Int!
    var instruction : String!
    var itemId : String!
    var name : String!
    var offer : DriverOrderOffer!
    var offerStatus : Int!
    var price : Int!
    var quantity : Int!
    var restaurantId : String!
    var vorousType : Int!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let customizeJson = json["customize"]
        if !customizeJson.isEmpty{
            customize = DriverOrderCustomize(fromJson: customizeJson)
        }
        finalPrice = json["finalPrice"].int ?? 0
        instruction = json["instruction"].string ?? ""
        itemId = json["itemId"].string ?? ""
        name = json["name"].string ?? ""
        let offerJson = json["offer"]
        if !offerJson.isEmpty{
            offer = DriverOrderOffer(fromJson: offerJson)
        }
        offerStatus = json["offerStatus"].int ?? 0
        price = json["price"].int ?? 0
        quantity = json["quantity"].int ?? 0
        restaurantId = json["restaurantId"].string ?? ""
        vorousType = json["vorousType"].int ?? 0
    }
    
}

class DriverOrderLoc{
    
    var lat : Float!
    var lng : Float!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        lat = json["lat"].float ?? 0.0
        lng = json["lng"].float ?? 0.0
    }
    
}

class DriverOrderOffer{
    
    var status : Int!
    var type : String!
    var value : Int!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        status = json["status"].int ?? 0
        type = json["type"].string ?? ""
        value = json["value"].int ?? 0
    }
    
}

class DriverOrderOrder{
    
    var base : Int!
    var billing : DriverOrderBilling!
    var code : String!
    var history : DriverOrderHistory!
    var instruction : String!
    var loc : DriverOrderLoc!
    var restaurantId : String!
    var status : Int!
    var statusText : String!
    var subOrderId : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        base = json["base"].int ?? 0
        let billingJson = json["billing"]
        if !billingJson.isEmpty{
            billing = DriverOrderBilling(fromJson: billingJson)
        }
        code = json["code"].string ?? ""
        let historyJson = json["history"]
        if !historyJson.isEmpty{
            history = DriverOrderHistory(fromJson: historyJson)
        }
        instruction = json["instruction"].string ?? ""
        let locJson = json["loc"]
        if !locJson.isEmpty{
            loc = DriverOrderLoc(fromJson: locJson)
        }
        restaurantId = json["restaurantId"].string ?? ""
        status = json["status"].int ?? 0
        statusText = json["statusText"].string ?? ""
        subOrderId = json["subOrderId"].string ?? ""
    }
    
}

class DriverOrderPayment{
    
    var mode : String!
    var repayStatus : Int!
    var status : Int!
    var throughType : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        mode = json["mode"].string ?? ""
        repayStatus = json["repayStatus"].int ?? 0
        status = json["status"].int ?? 0
        throughType = json["throughType"].string ?? ""
    }
    
}

class DriverOrderRestaurantIdData{
    
    var address : DriverOrderAddres!
    var available : Int!
    var avatar : String!
    var deliveryTime : Int!
    var id : String!
    var loc : DriverOrderLoc!
    var logo : String!
    var name : String!
    var perCapita : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let addressJson = json["address"]
        if !addressJson.isEmpty{
            address = DriverOrderAddres(fromJson: addressJson)
        }
        available = json["available"].int ?? 0
        avatar = json["avatar"].string ?? ""
        deliveryTime = json["deliveryTime"].int ?? 0
        id = json["id"].string ?? ""
        let locJson = json["loc"]
        if !locJson.isEmpty{
            loc = DriverOrderLoc(fromJson: locJson)
        }
        logo = json["logo"].string ?? ""
        name = json["name"].string ?? ""
        perCapita = json["perCapita"].string ?? ""
    }
    
}
