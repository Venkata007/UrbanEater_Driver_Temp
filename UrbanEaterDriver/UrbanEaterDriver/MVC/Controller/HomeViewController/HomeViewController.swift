//
//  HomeViewController.swift
//  DriverReadyToEat
//
//  Created by casperonios on 10/11/17.
//  Copyright © 2017 CasperonTechnologies. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import JSSAlertView

class HomeViewController: UIViewController , UIViewControllerTransitioningDelegate
{
    @IBOutlet weak var mapView: GMSMapView!
    
    var ConnectionTimer : Timer = Timer()
    
    @IBOutlet weak var switchOffline: UISwitch!
   // @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var offlineBtn: UIButton!
    @IBOutlet weak var driverImgView: UIImageView!
    var isOnline: Bool!
    
    @IBOutlet weak var NotVerify_view: UIView!
    let commonUtlity : Utilities = Utilities();
    var alertview = UIAlertController()
    
    
    let kButtonHeight = 50.0
    
    var disableInteractivePlayerTransitioning : Bool = false
    
    @IBOutlet weak var offlineStatus: UILabel!

    
//    var dummyView : UIView?
    var switch_isOn:Bool = Bool()
    
    @IBOutlet weak var buttonBillings: UIButton!
    
    var driverMarker = GMSMarker()
    
    /* ***common*** */
    
    var Latitude:String = String()
    var Longitude:String = String()
    var current_Location:CLLocation?
    var presentWindow : UIWindow?
    /* ****** */

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        isOnline = true
        
        UIView.hr_setToastThemeColor(color: UIColor(red: 199/255, green: 17/255, blue: 34/255, alpha: 1.0))
        presentWindow = UIApplication.shared.keyWindow

        //print("login mobileId ---->>> \(GlobalClass.driverModel.data.mobileId)")
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)

    }
    
    @IBAction func earningsBtnClicked(_ sender: Any) {
        let earningsVC = self.storyboard?.instantiateViewController(withIdentifier: "YourEarningsViewControllerID") as! YourEarningsViewController
        self.navigationController?.pushViewController(earningsVC, animated: true)
    }
    
    @IBAction func supportBtnClicked(_ sender: Any) {
        let helpVC = self.storyboard?.instantiateViewController(withIdentifier: "HelpSupportViewControllerID") as! HelpSupportViewController
        self.navigationController?.pushViewController(helpVC, animated: true)
    }
    



    
    @IBAction func onlineBtnClicked(_ sender: Any) {
        if !isOnline {
            goOnlineShowAlert()
        }
        
    }
    
    func goOnlineShowAlert(){
        
        var message = "Are you sure you want to go"
        message = "\(message) online ?"
        let alertview = JSSAlertView().show(self,title: "URBAN EATER",text: message,buttonText: "NO",cancelButtonText:"YES",color: #colorLiteral(red: 0.9529411765, green: 0.7529411765, blue: 0.1843137255, alpha: 1))
        alertview.addAction{
            
           // self.switchOffline.setOn(false, animated: false)
            print("online ---->>> no")
        }
        
        alertview.addCancelAction{
            print("online ---->>> yes")
            self.isOnline = true
//            self.OfflineWebHit(status: "1")
            
        }
        
    }
    
    func onlineBtnStateChange(){
        print("onlineBtnStateChange -------->>>")
        self.driverImgView.alpha = 1.0
        self.onlineBtn.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.7529411765, blue: 0.1843137255, alpha: 1)
        self.onlineBtn.layer.borderWidth = 0.0
        self.onlineBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        
        self.offlineBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.offlineBtn.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
        self.offlineBtn.layer.borderWidth = 1
        self.offlineBtn.layer.borderColor = #colorLiteral(red: 0.8871153236, green: 0.8871153236, blue: 0.8871153236, alpha: 1)
    }
    
    @IBAction func OfflineBtnClicked(_ sender: Any) {
        if isOnline {
            goOfflineShowAlert()
        }
    }
    
    func goOfflineShowAlert(){
        
        var message = "Are you sure you want to go"
        message = "\(message) offline ?"
        
        let alertview = JSSAlertView().show(self,title: "URBAN EATER",text: message,buttonText: "NO",cancelButtonText:"YES",color: #colorLiteral(red: 0.9529411765, green: 0.7529411765, blue: 0.1843137255, alpha: 1))
        
        alertview.addAction{
            print("offline no -------->>>")
        }
        
        alertview.addCancelAction{
            print("offline yes -------->>>")
            self.isOnline = false
            //self.OfflineWebHit(status: "0")
        }
        
    }
    
    func offlineBtnStateChange(){
        print("offlineBtnStateChange -------->>>")
        self.driverImgView.alpha = 0.2
        self.offlineBtn.backgroundColor = UIColor.red
        self.offlineBtn.layer.borderWidth = 0.0
        self.offlineBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        
        self.onlineBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.onlineBtn.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
        self.onlineBtn.layer.borderWidth = 1
        self.onlineBtn.layer.borderColor = #colorLiteral(red: 0.8871153236, green: 0.8871153236, blue: 0.8871153236, alpha: 1)
    }
    
//    @IBAction func ActionSwitchOffline(_ sender: Any)
//    {
//        print("ActionSwitchOffline");
//        
//        let toggle = sender as! UISwitch
//
//        var message = "Are you sure you want to go"
//        
//        if !toggle.isOn
//        {
//            message = "\(message) offline ?"
//            let alertview = JSSAlertView().showAlert(self,title: Theme.sharedInstance.GetAppname(),text: message,buttonText: "NO",cancelButtonText:"YES",color: UIColor(red: 206.0/255.0, green: 17.0/255.0, blue: 38/255.0, alpha: 1))
//            
//            alertview.addAction({ action in
//                
//                self.switchOffline.setOn(true, animated: false)
//            })
//            
//            alertview.addCancelAction({ action in
//                
//                if toggle.isOn
//                {
//                    print("status on")
//                    
//                    self.offlineStatus.text = "Online";
//                    
//                    self.OfflineWebHit(status: "1")
//                }
//                else
//                {
//                    print("status off")
//                    
//                    self.offlineStatus.text = "Offline";
//                    
//                    self.OfflineWebHit(status: "0")
//                }
//                
//            })
//        }
//        else
//        {
//            
//            message = "\(message) online ?"
//            let alertview = JSSAlertView().showAlert(self,title: Theme.sharedInstance.GetAppname(),text: message,buttonText: "NO",cancelButtonText:"YES",color: UIColor(red: 206.0/255.0, green: 17.0/255.0, blue: 38/255.0, alpha: 1))
//            alertview.addAction({ action in
//                
//                self.switchOffline.setOn(false, animated: false)
//            })
//            
//            alertview.addCancelAction({ action in
//                
//                if toggle.isOn
//                {
//                    print("status on")
//                    
//                    self.offlineStatus.text = "Online".MSlocalized;
//                    
//                    self.OfflineWebHit(status: "1")
//                }
//                else
//                {
//                    print("status off")
//                    
//                    self.offlineStatus.text = "Offline".MSlocalized;
//                    
//                    self.OfflineWebHit(status: "0")
//                }
//                
//            })
//            
//        }
//
//    }

  
    
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

extension UIImage {
    func makeImageWithColorAndSize(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

/* ***common*** */

extension HomeViewController
{
    func tracingLocation(_ currentLocation: CLLocation)
    {
        self.current_Location = currentLocation
        
        self.Latitude = "\(currentLocation.coordinate.latitude)"
        self.Longitude = "\(currentLocation.coordinate.longitude)"
        
        print("current_Location in home : ", Latitude, Longitude)
        
        //        LocationService.sharedInstance.stopUpdatingLocation()
    }
    
    func tracingLocationDidFailWithError(_ error: NSError) {
        
        print("location tracing error : ", error.localizedDescription)
    }
    
    func ChangeStatus(_ Locstatus: CLAuthorizationStatus)
    {
        if(LocationService.sharedInstance.Locstatus == .denied || LocationService.sharedInstance.Locstatus == .restricted)
        {
            let messageToShow = "Please allow location access in Settings"
            
            let alert = UIAlertController(title: "Alert", message: messageToShow, preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                
                (UIApplication.shared.delegate as! AppDelegate).setInitialViewController(from: "")
                
            }))
            
            self.present(alert, animated: true, completion: nil)
            
            //            let NoLocVC = storyboard?.instantiateViewController(withIdentifier:"NoLocVCID" ) as! NoLocVC
            //            self.navigationController?.present(NoLocVC, animated: true, completion: nil)
        }
    }
    
}



