//
//  ForgotPasswordViewController.swift
//  DriverReadyToEat
//
//  Created by Casperon iOS on 28/12/17.
//  Copyright © 2017 CasperonTechnologies. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController,OTPTextFieldDelegate
{
    @IBOutlet weak var mobileNoTxt: UITextField!
    
    @IBOutlet var OTP1: OTPTextField!
    @IBOutlet var OTP2: OTPTextField!
    @IBOutlet var OTP3: OTPTextField!
    @IBOutlet var OTP4: OTPTextField!
    
    @IBOutlet weak var newPasswordTxt: UITextField!
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    
    @IBOutlet weak var otpBtn: UIButton!
    @IBOutlet weak var verifyView: UIView!
    @IBOutlet weak var passwordView: UIView!
    
    @IBOutlet weak var otpViewHeightContraint: NSLayoutConstraint!
    var presentWindow : UIWindow?
    var otp:String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI(){
       // self.mobileNoTxt.placeholderRect("Mobile", color: .placeholderColor)
        //self.mobileNumberTF.leftViewImage(#imageLiteral(resourceName: "Mobile"))
        self.mobileNoTxt.delegate = self

        
        OTP1.delegate = self
        OTP2.delegate = self
        OTP3.delegate = self
        OTP4.delegate = self
        
        OTP1.addTarget(self, action: #selector(ForgotPasswordViewController.textFieldDidChange(_:)), for: .editingChanged)
        OTP2.addTarget(self, action: #selector(ForgotPasswordViewController.textFieldDidChange(_:)), for: .editingChanged)
        OTP3.addTarget(self, action: #selector(ForgotPasswordViewController.textFieldDidChange(_:)), for: .editingChanged)
        OTP4.addTarget(self, action: #selector(ForgotPasswordViewController.textFieldDidChange(_:)), for: .editingChanged)
    }

    
    @IBAction func sendOTPbtnAction(_ sender: UIButton) {
        if !self.validate(true){
            return
        }
        if sender.tag == 111 {
            otpViewHeightContraint.constant = 50
            otpBtn.setTitle("VERIFY", for: .normal)
            otpBtn.tag = 222
        }else{
            if self.validateOTP().0 {
                print("otp entered -------->>")
                verifyView.isHidden = true
                passwordView.isHidden = false
            }else{
                Theme.sharedInstance.showErrorpopup(Msg: "Enter 4-digit OTP")
            }

        }
    }
    


    
    @IBAction func ActionGo(_ sender: Any)
    {

    }
    
    func isValidEmail(testStr:String) -> Bool
    {
        print("validate emailId: \(testStr)")
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func ActionBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true);
    }

}

//MARK :- TextField Delegates
extension ForgotPasswordViewController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField){
        let text = textField.text
        if text?.utf16.count==1{
            switch textField{
            case OTP1:
                OTP2.becomeFirstResponder()
            case OTP2:
                OTP3.becomeFirstResponder()
            case OTP3:
                OTP4.becomeFirstResponder()
            case OTP4:
                OTP4.resignFirstResponder()
                break
            default:
                break
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
//        UIView.beginAnimations(nil, context: nil)
//        UIView.animate(withDuration: 0.25) {
//          //  self.verifyOTP.isEnabled = self.validateOTP().0
//        }
//        UIView.commitAnimations()
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
       // self.view.endEditing(true)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
//        UIView.beginAnimations(nil, context: nil)
//        UIView.animate(withDuration: 0.25) {
//
//        }
//        UIView.commitAnimations()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        print(string,range.location,range.length)
        if string == "\n"{
            textField.resignFirstResponder()
            // Return FALSE so that the final '\n' character doesn't get added
            return false
        }
        // For any other character return TRUE so that the text gets added to the view
        return true
    }
    
    func didPressBackspace(textField : OTPTextField){
        let text = textField.text
        print("Text",text ?? "No Text")
        if text?.utf16.count == 0{
            switch textField{
            case OTP4:
                OTP3.becomeFirstResponder()
            case OTP3:
                OTP2.becomeFirstResponder()
            case OTP2:
                OTP1.becomeFirstResponder()
            case OTP1: break
            default:
                break
            }
        }
    }
}

//MARK :- Validation
extension ForgotPasswordViewController{
    func validate(_ mobileNumber:Bool = false) -> Bool{
        if (self.mobileNoTxt.text?.isEmpty)! || (self.mobileNoTxt.text?.count)! < 10{
            Theme.sharedInstance.showErrorpopup(Msg: "Enter valid mobile number")
            //TheGlobalPoolManager.showToastView(ToastMessages.Invalid_Number)
            return false
        }else if !mobileNumber && !self.validateOTP().0{
            //TheGlobalPoolManager.showToastView(ToastMessages.Invalid_OTP)
            Theme.sharedInstance.showErrorpopup(Msg: "Enter the OTP")
            return false
        }
        return true
    }

    func validateOTP() -> (Bool,String){
        let otpTF = [OTP1,OTP2,OTP3,OTP4]
        var validation = true
        var otpString = ""
        for otp in otpTF{
            if (otp?.text?.isEmpty)!{
                validation = false
                break
            }
            otpString = otpString + (otp?.text)!
        }
        return (validation,otpString)
    }
    
}

//MARK:- Override Textfield Delegate
protocol OTPTextFieldDelegate : UITextFieldDelegate {
    func didPressBackspace(textField : OTPTextField)
}

//MARK :- Override TextField
class OTPTextField:UITextField{
    override func deleteBackward() {
        super.deleteBackward()
        // If conforming to our extension protocol
        if let pinDelegate = self.delegate as? OTPTextFieldDelegate {
            pinDelegate.didPressBackspace(textField: self)
        }
    }
    override func tintColorDidChange() {
        super.tintColorDidChange()
        self.tintColor = UIColor.white
    }
    override func caretRect(for position: UITextPosition) -> CGRect {
        var rect = super.caretRect(for: position)
        rect = CGRect(x: (self.bounds.width-2)/2, y: (self.bounds.height-25)/2, width: 2, height: 25)
        return rect
    }
}









