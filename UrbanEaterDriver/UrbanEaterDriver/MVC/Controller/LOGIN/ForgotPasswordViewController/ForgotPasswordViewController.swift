//
//  ForgotPasswordViewController.swift
//  DriverReadyToEat
//
//  Created by Casperon iOS on 28/12/17.
//  Copyright © 2017 CasperonTechnologies. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController
{
    @IBOutlet weak var emailID: UITextField!
    @IBOutlet weak var send_btn: UIButton!
    @IBOutlet weak var inputView: HDInputView!
    // @property (weak, nonatomic) IBOutlet HDInputView *inputView;
    var presentWindow : UIWindow?
    var otp:String = String()
    
    @IBOutlet weak var forgot_lbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.hr_setToastThemeColor(color: UIColor(red: 199/255, green: 17/255, blue: 34/255, alpha: 1.0))
        presentWindow = UIApplication.shared.keyWindow
        
        send_btn.layer.cornerRadius = 3.0
       // self.forgot_lbl.text = "Forgot Password".MSlocalized
        
        // Do any additional setup after loading the view.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
