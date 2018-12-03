//
//  AccountViewController.swift
//  DriverReadyToEat
//
//  Created by casperonios on 10/13/17.
//  Copyright © 2017 CasperonTechnologies. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class AccountViewController:UIViewController{
    
    @IBOutlet var profileImgView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var driverNameLbl: UILabel!
    @IBOutlet weak var phneNumberLbl: UILabel!
    @IBOutlet weak var driverIDLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var noOfOrdersLbl: UILabel!
    @IBOutlet weak var ratingsBtn: UIButton!
    
    var listImage = [#imageLiteral(resourceName: "editProfile"),#imageLiteral(resourceName: "resetPassword"),#imageLiteral(resourceName: "yourEarnings"),#imageLiteral(resourceName: "helpSupport")]
    var listMenu = ["Edit Profile","Reset Password","Your Earnings","Help & Support"]
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        self.ratingsBtn.setImage(#imageLiteral(resourceName: "Star").withColor(.whiteColor), for: .normal)
        TheGlobalPoolManager.cornerAndBorder(profileImgView, cornerRadius: profileImgView.layer.bounds.h / 2, borderWidth: 0, borderColor: .clear)
    }
    //MARK: - Pushing to Login
    func pushToLoginViewController(){
        if let viewCon = self.storyboard?.instantiateViewController(withIdentifier: "CustomLoginNavigationVCID") as? LoginViewController{
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            appdelegate.window!.rootViewController = viewCon
        }
    }
    func LogOut(){
        let alert = UIAlertController(title: "Warning!", message: "Are you sure, Do you want to logout?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .default) { (action) in
            TheGlobalPoolManager.logout()
            self.pushToLoginViewController()
        }
        let no = UIAlertAction(title: "No", style: .default) { (action) in
        }
        alert.addAction(yes)
        alert.addAction(no)
        ez.topMostVC?.presentVC(alert)
    }
}
// MARK:- UI Table View Cell Class
class OptionsCell : UITableViewCell{
    @IBOutlet weak var arrowImg: UIImageView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
}
class LogoutCell : UITableViewCell{
    @IBOutlet weak var titleLbl: UILabel!
}
// MARK:- UI Table View Delegates and Data Sources
extension AccountViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return listMenu.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if indexPath.row == 4{
            let cell : LogoutCell = tableView.dequeueReusableCell(withIdentifier: "LogoutCell") as! LogoutCell
            tableView.separatorStyle = .none
            return  cell
        }
        let cell : OptionsCell = tableView.dequeueReusableCell(withIdentifier: "OptionsCell") as! OptionsCell
        cell.titleLbl.text = listMenu[indexPath.row] as String
        cell.imgView.image = listImage[indexPath.row].withColor(.secondaryBGColor)
        tableView.separatorColor = #colorLiteral(red: 0.3294117647, green: 0.3294117647, blue: 0.3294117647, alpha: 0.1963024401)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4{
             self.LogOut()
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            switch indexPath.row{
            case 0:
                let controller : EditProfileVC = storyboard.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
                self.navigationController?.pushViewController(controller, animated: true)
                break
            case 1:
                let controller : ChangePasswordViewController = storyboard.instantiateViewController(withIdentifier: "ChangePasswordViewControllerID") as! ChangePasswordViewController
                self.navigationController?.pushViewController(controller, animated: true)
                break
            case 2:
                let controller : YourEarningsViewController = storyboard.instantiateViewController(withIdentifier: "YourEarningsViewControllerID") as! YourEarningsViewController
                self.navigationController?.pushViewController(controller, animated: true)
                break
            case 3:
                let controller : HelpSupportViewController = storyboard.instantiateViewController(withIdentifier: "HelpSupportViewControllerID") as! HelpSupportViewController
                self.navigationController?.pushViewController(controller, animated: true)
                break
            default:
                break
            }
        }
    }
}
