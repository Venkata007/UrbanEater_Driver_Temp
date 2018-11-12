//
//  SignUpViewController.swift
//  DriverReadyToEat
//
//  Created by Nagaraju on 19/10/18.
//  Copyright © 2018 CasperonTechnologies. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var mobileNumberTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var verifyLbl: UILabel!
    
    @IBOutlet weak var otpTxt: UITextField!
    let commonUtlity : Utilities = Utilities();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nameTxt.delegate = self
        self.emailTxt.delegate = self
        self.mobileNumberTxt.delegate = self
        self.passwordTxt.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        updateUI()
    }
    
    func updateUI(){
        nameTxt.placeholderColor("Name", color: .placeholderColor)
        emailTxt.placeholderColor("Mail", color: .placeholderColor)
        mobileNumberTxt.placeholderColor("Mobile", color: .placeholderColor)
        passwordTxt.placeholderColor("Password", color: .placeholderColor)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn -------->>>")
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, to: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }

    @IBAction func signupBtnClicked(_ sender: Any) {
       // registerBtn.backgroundColor = Themes.sharedInstance.returnButtonBackgroundColor()
        print("ActionRegister")
        
        if self.commonUtlity.trimString(string: self.nameTxt.text!)  == ""
        {
            Theme.sharedInstance.showErrorpopup(Msg: ToastMessages.Invalid_FirstName)
        }
        else if self.commonUtlity.trimString(string: mobileNumberTxt.text!) == ""
        {
            Theme.sharedInstance.showErrorpopup(Msg: ToastMessages.Invalid_Number)
        }
        else if self.commonUtlity.trimString(string: emailTxt.text!) == ""
        {
            Theme.sharedInstance.showErrorpopup(Msg: ToastMessages.Invalid_Email)
        }
        else if !isValidEmail(testStr: emailTxt.text!)
        {
            Theme.sharedInstance.showErrorpopup(Msg: ToastMessages.Invalid_Email)
        }

        else if self.commonUtlity.trimString(string: passwordTxt.text!) == ""
        {
            Theme.sharedInstance.showErrorpopup(Msg: ToastMessages.Invalid_Strong_Password)
        }
        else if !self.isStrongPassword(password: passwordTxt.text!) || !isvalidPassword(passwordTxt.text!)
        {
            Theme.sharedInstance.showErrorpopup(Msg: ToastMessages.Invalid_Strong_Password)
        }
        else
        {
           // GetRegisterData()
            
            blurView.isHidden = false
            let mobileNumber = mobileNumberTxt.text
            let lastDigits3:String = String(mobileNumber!.suffix(3))
            verifyLbl.text = "A text message with verification code was sent to(***) **** " + lastDigits3
        }
    }
    
    
    @IBAction func otpSubmitBtnClicked(_ sender: Any) {
        let otpText = self.commonUtlity.trimString(string: otpTxt.text!)
        if otpText.count == 4
        {
            blurView.isHidden = true
        }else{
            Theme.sharedInstance.showErrorpopup(Msg: "Enter the otp")
        }
        
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func loginBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func isStrongPassword(password : String) -> Bool
    {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()-_=+{}|?>.<,:;~`’]{6,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    func isValidEmail(testStr:String) -> Bool
    {
        print("validate emilId: \(testStr)")
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    func isvalidPassword(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^.{6,}$")
        return passwordTest.evaluate(with: password)
    }

    

    func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
