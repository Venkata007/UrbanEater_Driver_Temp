//
//  Constants.swift
//  UrbanEaterDriver
//
//  Created by Nagaraju on 05/11/18.
//  Copyright © 2018 Nagaraju. All rights reserved.
//

import UIKit

class Constants: NSObject {
    
    static let sharedInstance = Constants()
    //static let  BaseUrl = "http://13.233.109.143:3007/mobile/"
    static let  BaseUrl = "http://192.168.100.88:1234/api/v1/"

    //MARK:- Fonts
    public struct FontName {
        static let Light              = "Roboto-Light"
        static let Medium             = "Roboto-Medium"
        static let Regular            = "Roboto-Regular"
    }
    
    public struct urls {
        static let loginURL = "\(BaseUrl)customer/login"
    }

}
