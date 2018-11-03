//
//  LoginViewController.swift
//  DriverReadyToEat
//
//  Created by casperonios on 10/10/17.
//  Copyright © 2017 CasperonTechnologies. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIViewControllerTransitioningDelegate
{
    @IBOutlet weak var emailID: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var forgot_btn: UIButton!
    let commonUtlity : Utilities = Utilities();
   
    var presentWindow : UIWindow?
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var buttonLogin: UIButton!
    
    override func viewWillAppear(_ animated: Bool)
    {
       // buttonLogin.setTitleColor(Themes.sharedInstance.returnButtomFontColor(), for: .normal)
       // buttonLogin.normalBackgroundColor = Themes.sharedInstance.returnButtonBackgroundColor()
        
        buttonLogin.layer.cornerRadius = 5.0
        buttonLogin.layer.masksToBounds = true
        
       
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

//        self.emailID.text = "Parthasarathi.y@gmail.com"
//        self.password.text = "Sudheer1"
        
        self.emailID.text = "nagaraju@exadots.in"
        self.password.text = "Raju1234"

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    
    @IBAction func signupBtnClicked(_ sender: Any) {
        let signVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewControllerID") as! SignUpViewController
        self.navigationController?.pushViewController(signVC, animated: true)
    }
    


    @IBAction func ActionLogin(_ sender: Any)
    {
        
        print("ActionLogin")
        Theme.sharedInstance.activityView(View: self.view)
        
         _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.movoToHome(timer:)), userInfo: nil, repeats: false)
        
      //  let passwordString = self.commonUtlity.trimString(string: self.password.text!)
        
        if self.commonUtlity.trimString(string: self.emailID.text!)  == ""
        {
            //self.presentWindow?.makeToast(message: "Email can't be empty", duration: 3.0, position: HRToastPositionCenter as AnyObject, title: Themes.sharedInstance.GetAppname())
            Theme.sharedInstance.showErrorpopup(Msg: "Email can't be empty")
            //self.view.makeToast("Email can't be empty", duration: 3.0, position: .center)
          
        }
        else if !isValidEmail(testStr: emailID.text!)
        {
            //self.presentWindow?.makeToast(message: "Enter a Valid email id", duration: 3.0, position: HRToastPositionCenter as AnyObject, title: Themes.sharedInstance.GetAppname())
            Theme.sharedInstance.showErrorpopup(Msg: "Enter a Valid email id")
            //self.view.makeToast("Enter a Valid email id", duration: 3.0, position: .center)
            
        }
        else if self.commonUtlity.trimString(string: self.password.text!) == ""
        {
            //self.presentWindow?.makeToast(message: "Password can't be empty", duration: 3.0, position: HRToastPositionCenter as AnyObject, title: Themes.sharedInstance.GetAppname())
            Theme.sharedInstance.showErrorpopup(Msg: "Password can't be empty")
            //self.view.makeToast("Password can't be empty", duration: 3.0, position: .center)
          
        }
//        else if passwordString.count < 6
//        {
//            self.view.makeToast("Password minimum 6 characters", duration: 3.0, position: .center)
//        }
        else
        {
            
        }
       // buttonLogin.backgroundColor = Themes.sharedInstance.returnButtonBackgroundColor()
    }
    
    @objc func movoToHome(timer:Timer) {
        Theme.sharedInstance.removeActivityView(View: self.view)
        UserDefaults.standard.setValue("Nagaraju", forKey: "driverInfo")
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
    
    @IBAction func ActionForgotPassword(_ sender: Any)
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
