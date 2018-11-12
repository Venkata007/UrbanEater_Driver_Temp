//
//  AccountViewController.swift
//  DriverReadyToEat
//
//  Created by casperonios on 10/13/17.
//  Copyright © 2017 CasperonTechnologies. All rights reserved.
//

import UIKit
import JSSAlertView

class AccountViewController:UIViewController, UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource
{
    var listImage = [  "yourEarnings", "editProfile",  "resetPassword","helpSupport","logout"]
    
    var listMenu = [String]()
   // var  langArr = ["English","French"]
    
    @IBOutlet var profileImg_View: UIImageView!
    let commonUtlity : Utilities = Utilities()

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var account_tableview: UITableView!
    @IBOutlet weak var driverNameLbl: UILabel!
    

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        

        
        bottomView.layer.borderWidth = 1
        bottomView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        account_tableview.separatorStyle = .none
        
        profileImg_View.layer.cornerRadius = 40.0
        profileImg_View.layer.borderWidth = 1
        profileImg_View.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        profileImg_View.layer.masksToBounds = true


    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.driverNameLbl.text = ""
       
    }

    
    override func viewDidAppear(_ animated: Bool) {
         // listMenu = [ "Profile".MSlocalized, "Bank_Account_Details".MSlocalized , "Change_Password".MSlocalized,"Language","Log_out".MSlocalized]
        listMenu = ["Your Earnings","Edit Profile","Reset Password","Help & Support","Logout"]
        account_tableview.reloadData()
    }
    
    func LogOut()
    {
//        let alertView = JSSAlertView().showAlert(self,title: messageTxt ,text:nil,buttonText: "CANCEL",cancelButtonText:"CONFIRM"
//            ,color: UIColor.green)
//
//        alertView.addAction{
//            print("no logout --->>>")
//        }
//        alertView.addCancelAction({
//            print("yes logot --->>>")
//        })
        
        let alertView = JSSAlertView().show(self,title: "URBAN EATER" ,text:"Are you sure you want to logout ?",buttonText: "Cancel",cancelButtonText:"OK"
            ,color: #colorLiteral(red: 0.9529411765, green: 0.7529411765, blue: 0.1843137255, alpha: 1))
        
        alertView.addAction{
            print("no logout --->>>")
        }
        alertView.addCancelAction({
            print("yes logot --->>>")
            UserDefaults.standard.setValue(nil, forKey: "driverInfo")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let controller : UIViewController = storyboard.instantiateViewController(withIdentifier: "CustomLoginNavigationVCID")
            
            (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = controller
            
            (UIApplication.shared.delegate as! AppDelegate).window?.makeKeyAndVisible()
        })
        
    }

    
    // MARK : - tableview datasource and delegates
    
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return listMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : MoreTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellMore") as! MoreTableViewCell
        cell.titleMenu.text = listMenu[indexPath.row] as String
        
        cell.imageMenu.image = UIImage.init(named: self.listImage[indexPath.row] as String)
        //cell.preservesSuperviewLayoutMargins = false
        //cell.separatorInset = UIEdgeInsets.zero
        //cell.layoutMargins = UIEdgeInsets.zero
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectItem = self.listMenu[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        switch selectItem
        {
            case "Your Earnings":
               // let controller : PayoutInformationViewController = storyboard.instantiateViewController(withIdentifier: "PayoutInformationViewControllerID") as! PayoutInformationViewController
                let controller : YourEarningsViewController = storyboard.instantiateViewController(withIdentifier: "YourEarningsViewControllerID") as! YourEarningsViewController
                self.navigationController?.pushViewController(controller, animated: true)
                break;
            
            case "Edit Profile":
                //
                let controller : EditProfileViewController = storyboard.instantiateViewController(withIdentifier: "EditProfileVCID") as! EditProfileViewController
                self.navigationController?.pushViewController(controller, animated: true)
                break

            case "Reset Password":
                let controller : ChangePasswordViewController = storyboard.instantiateViewController(withIdentifier: "ChangePasswordViewControllerID") as! ChangePasswordViewController
                self.navigationController?.pushViewController(controller, animated: true)
                break
          
        case "Help & Support":
            let controller : HelpSupportViewController = storyboard.instantiateViewController(withIdentifier: "HelpSupportViewControllerID") as! HelpSupportViewController
            self.navigationController?.pushViewController(controller, animated: true)
            break

            case "Logout":
                self.LogOut()
                break

            default:
                break
        }
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
