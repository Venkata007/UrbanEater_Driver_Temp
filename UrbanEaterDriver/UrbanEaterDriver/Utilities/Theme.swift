//
//  Theme.swift
//  UrbanEaterDriver
//
//  Created by Nagaraju on 01/11/18.
//  Copyright © 2018 Nagaraju. All rights reserved.
//

import Foundation
import UIKit
import JSSAlertView
import SwiftMessages
import MMMaterialDesignSpinner

class Theme: NSObject {
    
    static let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    
    static let sharedInstance = Theme()
    
    let screenSize:CGRect = UIScreen.main.bounds
    var spinnerView:MMMaterialDesignSpinner=MMMaterialDesignSpinner()
    
    func showErrorpopup(Msg: String)
    {
        let success = MessageView.viewFromNib(layout: .cardView)
        success.configureTheme(.warning)
        
        success.configureContent(title: "Alert!", body: Msg, iconImage: #imageLiteral(resourceName: "NotificationIcon"), iconText: "", buttonImage: nil, buttonTitle: "Ok", buttonTapHandler: { (btnTapped) in
            print("Notification View Tap")
            SwiftMessages.hide()
        })
        
        //success.configureContent(title: Msg, body: "")
        success.button?.isHidden = true
        var successConfig = SwiftMessages.defaultConfig
        successConfig.presentationStyle = .top
        //successConfig.duration = .seconds(seconds: 2)
        successConfig.presentationContext = .window(windowLevel: UIWindowLevelNormal)
        SwiftMessages.show(config: successConfig, view: success)
    }
    
    func activityView(View:UIView)
    {
        View.isUserInteractionEnabled = false;
        spinnerView.frame=CGRect(x: View.center.x-25, y: View.center.y, width: 50, height: 50)
        spinnerView.lineWidth = 3.0;
        spinnerView.tintColor = #colorLiteral(red: 0, green: 0.7314415574, blue: 0.3181976676, alpha: 1)
        //spinnerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2040881849)
        View.addSubview(spinnerView)
        spinnerView.startAnimating()
    }
    
    func removeActivityView(View:UIView)
    {
        View.isUserInteractionEnabled = true;
        spinnerView.stopAnimating()
        spinnerView.removeFromSuperview()
    }
    
    func rotateImage(image: UIImage) -> UIImage {
        if (image.imageOrientation == UIImageOrientation.up ) {
            return image
        }
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        let copy = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return copy!
    }
    
    func GetAppname()->String
    {
        var appname:String=self.CheckNullvalue(Passed_value: Bundle.main.infoDictionary!["CFBundleDisplayName"])
        return appname
        
    }
    
    func CheckNullvalue(Passed_value:Any?) -> String {
        var Param:Any?=Passed_value
        if(Param == nil || Param is NSNull)
        {
            Param=""
        }
        else
        {
            Param = String(describing: Passed_value!)
        }
        return Param as! String
    }
}
