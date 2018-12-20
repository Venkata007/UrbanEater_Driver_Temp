//
//  GlobalModel.swift
//  DinedooRestaurant
//
//  Created by Nagaraju on 02/11/18.
//  Copyright © 2018 casperonIOS. All rights reserved.
//

import Foundation
import EZSwiftExtensions
import Toast_Swift

let TheGlobalPoolManager = GlobalModel.sharedInstance

class GlobalModel:NSObject {
    let device_id = UIDevice.current.identifierForVendor!.uuidString
    var view:UIView{return (ez.topMostVC?.view)!}
    var vc:UIViewController{return ez.topMostVC!}
    typealias AlertCallback = (Bool?) -> ()
    static let sharedInstance = GlobalModel()
    let DELIVERED             = "DELIVERED"
    let ON_GOING            = "ON_GOING"
    var driverLoginModel:DriverLoginModel!
    var updatePasswordModel : UpdatePasswordModel!
    var driverHomeModel : DriverHomeModel!
    var driverOrderModel : DriverOrderModel!
    var earningsDataModel : EarningsDataModel!
    
    override init() {
        super.init()
    }
    func showToastView(_ title: String) {
        topMostVC()?.view.makeToast(title, duration: 2.0, position: .bottom)
    }
    //MARK:- Store in Userdefaults
    func storeInDefaults(_ value:AnyObject, key:String){
        UserDefaults.standard.set(value, forKey: key)
    }
    //MARK: Retrieve from userdefaults
    func retrieveFromDefaultsFor(_ key:String) -> AnyObject?{
        return UserDefaults.standard.object(forKey: key) as AnyObject
    }
    func cornerRadius(_ object:AnyObject, cornerRad:CGFloat){
        object.layer.cornerRadius = cornerRad
        object.layer.masksToBounds = true
    }
    //MARK:- UIButton Border and Corner radius
    func cornerAndBorder(_ object:AnyObject, cornerRadius : CGFloat , borderWidth : CGFloat, borderColor:UIColor)  {
        object.layer.borderColor = borderColor.cgColor
        object.layer.borderWidth = borderWidth
        object.layer.cornerRadius = cornerRadius
        object.layer.masksToBounds = true
    }
    //MARK:- corner Radius For Header
    func cornerRadiusForParticularCornerr(_ object:AnyObject,  corners:UIRectCorner,  size:CGSize){
        let path = UIBezierPath(roundedRect:object.bounds,
                                byRoundingCorners:corners,
                                cornerRadii: size)
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        object.layer.mask = maskLayer
    }
    //MARK:- NS Attributed Text With Color and Font
    func attributedTextWithTwoDifferentTextsWithFont(_ attr1Text : String , attr2Text : String , attr1Color : UIColor , attr2Color : UIColor , attr1Font : Int , attr2Font : Int , attr1FontName : AppFonts , attr2FontName : AppFonts) -> NSAttributedString{
        let attrs1 = [NSAttributedStringKey.font : UIFont.init(name: attr1FontName.fonts, size: CGFloat(attr1Font))!, NSAttributedStringKey.foregroundColor : attr1Color] as [NSAttributedStringKey : Any]
        let attrs2 = [NSAttributedStringKey.font : UIFont.init(name: attr2FontName.fonts, size: CGFloat(attr2Font))!, NSAttributedStringKey.foregroundColor : attr2Color] as [NSAttributedStringKey : Any]
        let attributedString1 = NSMutableAttributedString(string:attr1Text, attributes:attrs1)
        let attributedString2 = NSMutableAttributedString(string:attr2Text, attributes:attrs2)
        attributedString1.append(attributedString2)
        return attributedString1
    }
    //MARK:- UIAlertController
    func showAlertWith(title:String = "", message:String, singleAction:Bool,  okTitle:String = "Ok", cancelTitle:String = "Cancel", callback:@escaping AlertCallback) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: okTitle, style: .default) { action -> Void in
            callback(true)
        }
        if !singleAction{
            let cancelAction: UIAlertAction = UIAlertAction(title: cancelTitle, style: .default) { action -> Void in
                //Just dismiss the action sheet
                callback(false)
            }
            alertController.addAction(cancelAction)
        }
        alertController.addAction(okAction)
        ez.runThisInMainThread {
            self.vc.presentVC(alertController)
        }
    }
    //MARK : - Logout Method
    func logout(){
        if let bundle = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundle)
            UIApplication.shared.unregisterForRemoteNotifications()
        }
    }
    //MARK: - Text Field Frame and Corner radius
    func textFieldFrame(_ tf: UITextField, placeHolder placeStr: String) {
        let color = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1).cgColor
        tf.attributedPlaceholder = NSAttributedString(string: placeStr, attributes: [NSAttributedStringKey.foregroundColor: color])
        tf.layer.masksToBounds = true
    }
    //MARK: - Change the Date Formatter
    func convertDateFormater(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return  dateFormatter.string(from: date!)
    }
    func topMostVC() -> UIViewController?{
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
}
class UILabelPadded: UILabel {
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
}

class UITextFieldPadded: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 25)
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}
class ButtonWithShadow: UIButton {
    override func draw(_ rect: CGRect) {
        updateLayerProperties()
    }
    func updateLayerProperties() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 3.0
        self.layer.masksToBounds = false
    }
}
