//
//  ChangePasswordViewController.swift
//  DriverReadyToEat
//
//  Created by Casperon iOS on 01/12/17.
//  Copyright © 2017 CasperonTechnologies. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController
{

    @IBOutlet weak var containerGoButton: UIView!
    
    let commonUtlity : Utilities = Utilities();

    @IBOutlet weak var oldpassword: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    var presentWindow : UIWindow?
    
    override func viewDidLoad()
    {
    
        super.viewDidLoad()

        UIView.hr_setToastThemeColor(color: UIColor(red: 199/255, green: 17/255, blue: 34/255, alpha: 1.0))
        presentWindow = UIApplication.shared.keyWindow
        // Do any additional setup after loading the view.
        //containerGoButton.layer.cornerRadius = 50/2;
        //containerGoButton.clipsToBounds = true
        //containerGoButton.layer.shadowOpacity = 0.7
        //containerGoButton.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        //containerGoButton.layer.shadowRadius = 15.0
        //containerGoButton.layer.shadowColor = UIColor.lightGray.cgColor
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
    }

    
    func LogOut()
    {
        UserDefaults.standard.setValue(nil, forKey: "driverInfo")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let controller : UIViewController = storyboard.instantiateViewController(withIdentifier: "CustomLoginNavigationVCID")
        
        (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = controller
        
        (UIApplication.shared.delegate as! AppDelegate).window?.makeKeyAndVisible()

    }

    
    @IBAction func ActionSubmit(_ sender: Any)
    {
        print("ActionSubmit")
        
        if self.commonUtlity.trimString(string: self.oldpassword.text!) == ""
        {
//            SWMessage.sharedInstance.showNotificationWithTitle(
//                Theme.sharedInstance.GetAppname(),
//                subtitle: "Enter old password",
//                type: .warning
//            )
            
            //self.view.makeToast(message: "Enter old password", duration: 3.0, position: HRToastPositionTop as AnyObject, title: Theme.sharedInstance.GetAppname())
            Theme.sharedInstance.showErrorpopup(Msg: "Enter old password")
            //self.view.makeToast("Enter old password", duration: 3.0 , position: .center)
        }
        else if self.commonUtlity.trimString(string: self.password.text!) == ""
        {
            Theme.sharedInstance.showErrorpopup(Msg: "Enter new password")
            //self.view.makeToast("Enter new password", duration: 3.0 , position: .center)
        }
        else if self.commonUtlity.trimString(string: self.confirmPassword.text!) == ""
        {

            Theme.sharedInstance.showErrorpopup(Msg: "Enter confirm password")
            //self.view.makeToast("Enter confirm password", duration: 3.0 , position: .center)
        }
//        else if !isvalidPassword(password.text!)
//        {
//            self.view.makeToast("Password minimum 6 characters", duration: 3.0, position: .center)
//        }
        else if !self.isStrongPassword(password: password.text!) || !isvalidPassword(password.text!)
        {
            Theme.sharedInstance.showErrorpopup(Msg: "Password should be at least 6 characters, which Contain At least One uppercase, One lower case, One Numeric digit.")
            //self.view.makeToast("Password should be at least 6 characters, which Contain At least One uppercase, One lower case, One Numeric digit.", duration: 3.0, position: .center)
        }
        else if self.confirmPassword.text! != self.password.text!
        {
            Theme.sharedInstance.showErrorpopup(Msg: "New Password should match with confirm password")
            //self.view.makeToast("New Password should match with confirm password", duration: 3.0 , position: .center)
        }
        else
        {
           
        }
        
    }
    
    func isvalidPassword(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^.{6,}$")
        return passwordTest.evaluate(with: password)
    }
    
    public func isStrongPassword(password : String) -> Bool
    {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()-_=+{}|?>.<,:;~`’]{6,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    
    @IBAction func ActionBack(_ sender: Any)
    {
        _ = self.navigationController?.popViewController(animated: true)
        
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
