//
//  LoginViewController.swift
//  DriverReadyToEat
//
//  Created by casperonios on 10/10/17.
//  Copyright © 2017 CasperonTechnologies. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: UIViewController, UIViewControllerTransitioningDelegate
{
    @IBOutlet weak var mobileNoTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    let commonUtlity : Utilities = Utilities();
   
    var presentWindow : UIWindow?
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewWillAppear(_ animated: Bool)
    {

    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        UIView.hr_setToastThemeColor(color: UIColor(red: 199/255, green: 17/255, blue: 34/255, alpha: 1.0))
        presentWindow = UIApplication.shared.keyWindow
        
        var deviceToken = ""
        
        if UserDefaults.standard.string(forKey: "deviceToken") != nil
        {
            deviceToken = UserDefaults.standard.string(forKey: "deviceToken")!
        }

        print(" self.commonUtlity.appDelegate.deviceToken : ",  deviceToken)
//        self.mobileNoTxt.text = "9032363049"
//        self.passwordTxt.text = "Raju1234"
        
        updateUI()

    }
    
    
    func updateUI(){
        mobileNoTxt.placeholderColor("Mobile", color: .placeholderColor)
        passwordTxt.placeholderColor("Password", color: .placeholderColor)
    }
    
    
    @IBAction func signupBtnClicked(_ sender: Any) {
        let signVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewControllerID") as! SignUpViewController
        self.navigationController?.pushViewController(signVC, animated: true)
    }
    
    @IBAction func ActionLogin(_ sender: Any)
    {
        print("ActionLogin")
        if self.commonUtlity.trimString(string: self.mobileNoTxt.text!) == "" {
            Theme.sharedInstance.showErrorpopup(Msg: ToastMessages.mobile_number_empty)
        }
        else if self.commonUtlity.trimString(string: self.passwordTxt.text!) == ""
        {
            Theme.sharedInstance.showErrorpopup(Msg: ToastMessages.password_empty)
        }

        else
        {
            LoginWebHit()
        }
    }
    
    func LoginWebHit()
    {
        self.view.endEditing(true)
        Theme.sharedInstance.activityView(View: self.view)
        
        let email = "9876543210" //self.newPasswordTxt.text!
        let password =  "testing123"//self.confirmPasswordTxt.text!
        
        let param = [
            "mobileId": email,
            "password": password,
            "through": "WEB"
        ]
        
        print("loginURL ----->>> ", Constants.urls.loginURL)
        
        print("param login ----->>> ", param)
        
        URLhandler.postUrlSession(urlString: Constants.urls.loginURL, params: param as [String : AnyObject], header: [:]) { (dataResponse) in
            print("Response login ----->>> ", dataResponse.json)
            Theme.sharedInstance.removeActivityView(View: self.view)
            if dataResponse.json.exists(){
                 //print("Response login ----->>> ", dataResponse.json) 6369
                UserDefaults.standard.set(dataResponse.dictionaryFromJson, forKey: "driverInfo")
                TheGlobalPoolManager.driverModel = DriverModel(fromJson: dataResponse.json)
                
//                _ = Timer.scheduledTimer(timeInterval:1.0, target: self, selector: #selector(self.movoToHome(timer:)), userInfo: nil, repeats: false)
                self.movoToHome()
              
            }
        }
    }
    
    
    @objc func movoToHome() {
        Theme.sharedInstance.removeActivityView(View: self.view)
        (UIApplication.shared.delegate as! AppDelegate).setInitialViewController(from: "")
    }
    
    
    public func isStrongPassword(password : String) -> Bool
    {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()-_=+{}|?>.<,:;~`’]{6,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    func isValidEmail(testStr:String) -> Bool
    {
        print("validate emailId: \(testStr)")
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    @IBAction func ActionBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func loginWithOTPAction(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let controller : ForgotPasswordViewController = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordViewControllerID") as! ForgotPasswordViewController
        self.navigationController?.pushViewController(controller, animated: true)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
