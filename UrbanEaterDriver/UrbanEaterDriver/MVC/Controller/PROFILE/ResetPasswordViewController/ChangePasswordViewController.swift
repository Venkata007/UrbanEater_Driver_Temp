//
//  ChangePasswordViewController.swift
//  DriverReadyToEat
//
//  Created by Casperon iOS on 01/12/17.
//  Copyright © 2017 CasperonTechnologies. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class ChangePasswordViewController: UIViewController{

    @IBOutlet weak var oldpassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        self.oldpassword.setBottomBorder()
        self.password.setBottomBorder()
        self.confirmPassword.setBottomBorder()
    }
    func isvalidPassword(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^.{6,}$")
        return passwordTest.evaluate(with: password)
    }
    public func isStrongPassword(password : String) -> Bool{
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()-_=+{}|?>.<,:;~`’]{6,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    func validate() -> Bool{
        if (self.oldpassword.text?.isEmpty)!{
            Theme.sharedInstance.showErrorpopup(Msg: "Invalid Old Password")
            return false
        }else if (self.password.text?.isEmpty)!{
            Theme.sharedInstance.showErrorpopup(Msg: "Invalid New Password")
            return false
        }else if (self.confirmPassword.text?.isEmpty)!{
            Theme.sharedInstance.showErrorpopup(Msg: "Invalid Confirm Password")
            return false
        }else if !isStrongPassword(password: password.text!){
            Theme.sharedInstance.showErrorpopup(Msg: "New Password length is too short... 🤪")
            return false
        }else if !isStrongPassword(password: confirmPassword.text!){
            Theme.sharedInstance.showErrorpopup(Msg: "Confirm Password length is too short... 🤪")
            return false
        }else if password.text != confirmPassword.text{
            Theme.sharedInstance.showErrorpopup(Msg: "Oops! Password miss match... 🤪")
            return false
        }
        return true
    }
    //MARK: - Change Password Api Hitting
    func changePasswordApiHitting() {
        Theme.sharedInstance.activityView(View: self.view)
        let param = ["id": TheGlobalPoolManager.driverLoginModel.data.subId!,
                                "currentPassword": oldpassword.text!,
                                "newPassword": self.password.text!]
        
        URLhandler.postUrlSession(urlString: Constants.urls.ChangePassword, params: param as [String : AnyObject], header: [:]) { (dataResponse) in
            Theme.sharedInstance.removeActivityView(View: self.view)
            if dataResponse.json.exists(){
                let dict = dataResponse.dictionaryFromJson! as NSDictionary
                Theme.sharedInstance.showErrorpopup(Msg: dict.object(forKey: "message") as! String)
                 _ = self.navigationController?.popViewController(animated: true)
            }
        }
    }
    //MARK:- IB Action Outlets
    @IBAction func ActionSubmit(_ sender: Any){
        print("ActionSubmit")
        if validate(){
            self.changePasswordApiHitting()
        }
    }
    @IBAction func ActionBack(_ sender: Any){
        _ = self.navigationController?.popViewController(animated: true)
    }
}
