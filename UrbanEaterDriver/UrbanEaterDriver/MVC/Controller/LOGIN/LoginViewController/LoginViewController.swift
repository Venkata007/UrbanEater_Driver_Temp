//
//  LoginViewController.swift
//  DriverReadyToEat
//
//  Created by casperonios on 10/10/17.
//  Copyright © 2017 CasperonTechnologies. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: UIViewController, UIViewControllerTransitioningDelegate{
    @IBOutlet weak var mobileNoTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    let commonUtlity : Utilities = Utilities();
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad(){
        super.viewDidLoad()
       self.updateUI()
    }
    func updateUI(){
        self.mobileNoTxt.text = "9553322662"
        self.passwordTxt.text = "Srikanth@1234"
        mobileNoTxt.placeholderColor("Mobile", color: .placeholderColor)
        passwordTxt.placeholderColor("Password", color: .placeholderColor)
    }
    @IBAction func ActionLogin(_ sender: Any){
        print("ActionLogin")
        if self.commonUtlity.trimString(string: self.mobileNoTxt.text!) == "" {
            Theme.sharedInstance.showErrorpopup(Msg: ToastMessages.mobile_number_empty)
        }else if self.commonUtlity.trimString(string: self.passwordTxt.text!) == ""{
            Theme.sharedInstance.showErrorpopup(Msg: ToastMessages.password_empty)
        }else {
            LoginWebHit()
        }
    }
    func LoginWebHit() {
        self.view.endEditing(true)
        Theme.sharedInstance.activityView(View: self.view)
        let param = ["password": passwordTxt.text!,
                               "mobileId": mobileNoTxt.text!,
                               "through": "MOBILE",
                               "deviceInfo": ["deviceToken": "12345678901234567890",
                                                        "deviceId": TheGlobalPoolManager.device_id]
            ] as [String : Any]
        URLhandler.postUrlSession(urlString: Constants.urls.loginURL, params: param as [String : AnyObject], header: [:]) { (dataResponse) in
            Theme.sharedInstance.removeActivityView(View: self.view)
            if dataResponse.json.exists(){
                UserDefaults.standard.set(dataResponse.dictionaryFromJson, forKey: "driverInfo")
                TheGlobalPoolManager.driverLoginModel = DriverLoginModel(fromJson: dataResponse.json)
                self.movoToHome()
            }
        }
    }
    @objc func movoToHome() {
        Theme.sharedInstance.removeActivityView(View: self.view)
        (UIApplication.shared.delegate as! AppDelegate).setInitialViewController(from: "")
    }
    public func isStrongPassword(password : String) -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()-_=+{}|?>.<,:;~`’]{6,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    func isValidEmail(testStr:String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    @IBAction func loginWithOTPAction(_ sender: Any){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller : ForgotPasswordVC = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.present(controller, animated: true, completion: nil)
    }
}
