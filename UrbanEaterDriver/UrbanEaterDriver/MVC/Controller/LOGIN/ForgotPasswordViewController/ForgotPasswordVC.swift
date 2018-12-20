//
//  ForgotPasswordVC.swift
//  UrbanEaterRestaurant
//
//  Created by Vamsi on 14/12/18.
//  Copyright © 2018 Nagaraju. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var emailID: UITextField!
    @IBOutlet weak var sendOTPBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        emailID.placeholderColor("Mobile Number", color: .placeholderColor)
        TheGlobalPoolManager.cornerAndBorder(sendOTPBtn, cornerRadius: 8, borderWidth: 0, borderColor: .clear)
    }
    //MARK:- Validate
    func validate() -> Bool{
        if (self.emailID.text?.isEmpty)! {
            Theme.sharedInstance.showErrorpopup(Msg: ToastMessages.Invalid_Number)
            return false
        }else if self.emailID.text?.length != 10 {
            Theme.sharedInstance.showErrorpopup(Msg: ToastMessages.Invalid_Number)
            return false
        }
        return true
    }
    //MARK:- Pushing to OTP VC
    func presentingOTPVC(){
        let viewCon = self.storyboard?.instantiateViewController(withIdentifier: "OTPViewController")as? OTPViewController
        self.present(viewCon!, animated: true, completion: nil)
    }
    //MARK:- Send OTP Api Hitting
    func sendOTPApiMethod(){
        if validate(){
            Theme.sharedInstance.activityView(View: self.view)
            let param = [
                "mobileId": emailID.text!,
                "through": "MOBILE"
                ] 
            
            URLhandler.postUrlSession(urlString: Constants.urls.ForgotPassword, params: param as [String : AnyObject], header: [:]) { (dataResponse) in
                print("Response  ----->>> ", dataResponse.json)
                Theme.sharedInstance.removeActivityView(View: self.view)
                if dataResponse.json.exists(){
                    TheGlobalPoolManager.updatePasswordModel = UpdatePasswordModel.init(fromJson: dataResponse.json)
                    self.presentingOTPVC()
                }
            }
        }
    }
    //MARK:- IB Action Outlets
    @IBAction func sendOTPBtn(_ sender: UIButton) {
        self.view.endEditing(true)
        self.sendOTPApiMethod()
    }
    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
