//
//  AccountViewController.swift
//  DriverReadyToEat
//
//  Created by casperonios on 10/13/17.
//  Copyright © 2017 CasperonTechnologies. All rights reserved.
//

import UIKit
import EZSwiftExtensions
import SDWebImage

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
        //self.updateUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        self.ratingsBtn.setImage(#imageLiteral(resourceName: "Star").withColor(.whiteColor), for: .normal)
        TheGlobalPoolManager.cornerAndBorder(profileImgView, cornerRadius: profileImgView.layer.bounds.h / 2, borderWidth: 0, borderColor: .clear)
        if TheGlobalPoolManager.driverHomeModel != nil{
            let data = TheGlobalPoolManager.driverHomeModel.data
            self.phneNumberLbl.text = data?.mobileId!
            self.driverIDLbl.text = data?.code.uppercased()
            self.driverNameLbl.text = data?.name!
            self.cityLbl.text = data?.cityName!
            self.noOfOrdersLbl.text = data?.statIdData.order.delivered!.toString
            let url = URL.init(string: Constants.BASEURL_IMAGE + (data?.avatar!)!)
           profileImgView.sd_setImage(with: url ,placeholderImage:  #imageLiteral(resourceName: "Head")) { (image, error, cache, url) in
                if error != nil{
                }else{
                    self.profileImgView.image = image
                }
            }
            self.ratingsBtn.setTitle(String(TheGlobalPoolManager.driverHomeModel.data.statIdData.rating.average!.rounded(toPlaces: 1)), for: .normal)
        }
    }
    //MARK: - Pushing to Login
    func pushToLoginViewController(){
        if let viewCon = self.storyboard?.instantiateViewController(withIdentifier: "CustomLoginNavigationVCID"){
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            appdelegate.window!.rootViewController = viewCon
        }
    }
    func LogOut(){
        TheGlobalPoolManager.showAlertWith(title: "Are you sure", message: "Do you want to logout?", singleAction: false, okTitle:"Confirm") { (sucess) in
            if sucess!{
                TheGlobalPoolManager.logout()
                self.pushToLoginViewController()
            }
        }
    }
    //MARK:- Driver Logout Api
    func driverLogoutApi(){
        let param = [ "id": TheGlobalPoolManager.driverLoginModel.data.subId!,
                                "through": "status"] as [String : Any]
        URLhandler.postUrlSession(urlString: Constants.urls.DriverLogout, params: param as [String : AnyObject], header: [:]) { (dataResponse) in
            if dataResponse.json.exists(){
                self.LogOut()
                let dict = dataResponse.dictionaryFromJson! as NSDictionary
                Theme.sharedInstance.showErrorpopup(Msg: dict.object(forKey: "message") as! String)
            }
        }
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
             self.driverLogoutApi()
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
