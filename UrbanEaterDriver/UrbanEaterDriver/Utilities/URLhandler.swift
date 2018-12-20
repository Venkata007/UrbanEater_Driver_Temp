//
//  URLhandler.swift
//  UrbanEaterDriver
//
//  Created by Nagaraju on 05/11/18.
//  Copyright © 2018 Nagaraju. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class URLhandler: NSObject {
    static let sharedInstance = URLhandler()
    func topMostVC() -> UIViewController?{
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
    // MARK : - Get Api hitting Model
    class func getUrlSession(urlString: String, params: [String : AnyObject]? ,header : [String : String] ,  completion completionHandler:@escaping (_ response: DataResponse<Any>) -> ()) {
        Alamofire.request(urlString,method: .get, parameters: params,encoding : JSONEncoding.default, headers: header).responseJSON { (response) in
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    let dic = response.result.value as! [String : AnyObject]
                    let stautsCode = dic["statusCode"] as! NSNumber
                    let message     = dic["message"] as! String
                    if stautsCode == 200 || stautsCode == 202{
                        completionHandler(response)
                    }else{
                        URLhandler.sharedInstance.topMostVC()?.view.makeToast(message:message)
                        Theme.sharedInstance.removeActivityView(View: (URLhandler.sharedInstance.topMostVC()?.view)!)
                    }
                }
                break
            case .failure(_):
                URLhandler.sharedInstance.topMostVC()?.view.makeToast(message: (response.result.error?.localizedDescription)!)
                Theme.sharedInstance.removeActivityView(View: (URLhandler.sharedInstance.topMostVC()?.view)!)
                break
            }
        }
    }
    // MARK : - Post Api hitting Model
    class func postUrlSession(urlString: String, params: [String : AnyObject] ,header : [String : String] ,  completion completionHandler:@escaping (_ response: DataResponse<Any>) -> ()) {
        Alamofire.request(urlString,method: .post, parameters: params,encoding : JSONEncoding.default, headers: header).responseJSON { (response) in
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    let dic = response.result.value as! [String : AnyObject]
                    print("dic ----->>> \(dic)")
                    let stautsCode = dic["statusCode"] as! NSNumber
                    let message     = dic["message"] as! String
                    if stautsCode == 200 || stautsCode == 202{
                        completionHandler(response)
                    }else{
                        URLhandler.sharedInstance.topMostVC()?.view.makeToast(message: message)
                        Theme.sharedInstance.removeActivityView(View: (URLhandler.sharedInstance.topMostVC()?.view)!)
                    }
                }
                break
            case .failure(_):
                URLhandler.sharedInstance.topMostVC()?.view.makeToast(message: (response.result.error?.localizedDescription)!)
                Theme.sharedInstance.removeActivityView(View: (URLhandler.sharedInstance.topMostVC()?.view)!)
                break
            }
        }
    }
    // MARK : - Delete Api hitting Model
    class func deleteUrlSession(urlString: String, params: [String : AnyObject]? ,header : [String : String] ,  completion completionHandler:@escaping (_ response: DataResponse<Any>) -> ()) {
        Alamofire.request(urlString,method: .delete, parameters: params,encoding : JSONEncoding.default, headers: header).responseJSON { (response) in
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    let dic = response.result.value as! [String : AnyObject]
                    let stautsCode = dic["statusCode"] as! NSNumber
                    let message     = dic["message"] as! String
                    if stautsCode == 200 || stautsCode == 202{
                        completionHandler(response)
                    }else{
                        URLhandler.sharedInstance.topMostVC()?.view.makeToast(message: message)
                        Theme.sharedInstance.removeActivityView(View: (URLhandler.sharedInstance.topMostVC()?.view)!)
                    }
                }
                break
            case .failure(_):
                URLhandler.sharedInstance.topMostVC()?.view.makeToast(message: (response.result.error?.localizedDescription)!)
                Theme.sharedInstance.removeActivityView(View: (URLhandler.sharedInstance.topMostVC()?.view)!)
                break
            }
        }
    }
    // MARK : - Put Api hitting Model
    class func putUrlSession(urlString: String, params: [String : AnyObject] ,header : [String : String] ,  completion completionHandler:@escaping (_ response: DataResponse<Any>) -> ()) {
        Alamofire.request(urlString,method: .put, parameters: params,encoding : JSONEncoding.default, headers: header).responseJSON { (response) in
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    let dic = response.result.value as! [String : AnyObject]
                    let stautsCode = dic["statusCode"] as! NSNumber
                    let message     = dic["message"] as! String
                    if stautsCode == 200 || stautsCode == 202{
                        completionHandler(response)
                    }else{
                        URLhandler.sharedInstance.topMostVC()?.view.makeToast(message: message)
                        Theme.sharedInstance.removeActivityView(View: (URLhandler.sharedInstance.topMostVC()?.view)!)
                    }
                }
                break
            case .failure(_):
                URLhandler.sharedInstance.topMostVC()?.view.makeToast(message: (response.result.error?.localizedDescription)!)
                Theme.sharedInstance.removeActivityView(View: (URLhandler.sharedInstance.topMostVC()?.view)!)
                break
            }
        }
    }
}

extension DataResponse{
    var json:JSON {
        return JSON(self.result.value as Any)
    }
    var dictionary:[String:AnyObject]?{
        return try! JSONSerialization.jsonObject(with: self.result.value as! Data, options: .init(rawValue: 0)) as? [String:AnyObject]
    }
    var userDetails:[String:AnyObject]?{
        return dictionary?["userDetails"] as? [String:AnyObject]
    }
    var dictionaryFromJson:[String:AnyObject]?{
        return self.result.value as? [String:AnyObject]
    }
    var userDetailsFromJson:[String:AnyObject]?{
        return dictionaryFromJson?["userDetails"] as? [String:AnyObject]
    }
}

extension String{
    var toInt:Int{
        return Int(self)!
    }
}
