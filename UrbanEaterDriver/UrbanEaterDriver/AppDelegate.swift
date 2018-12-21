//
//  AppDelegate.swift
//  UrbanEaterDriver
//
//  Created by Nagaraju on 01/11/18.
//  Copyright © 2018 Nagaraju. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SwiftyJSON

import GoogleMaps
import GooglePlaces
import Reachability
import Firebase
import FirebaseMessaging
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {

    var window: UIWindow?
    let googleApiKey = "AIzaSyAufQUMZP7qdjtOcGIuNFRSL-8uU6uuvGY"
    var IsInternetconnected:Bool=Bool()
    var gcmMessageIDKey = "gcm.message_id"
    var gcmNotificationIDKey = "gcm.notification.payload"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
         self.ReachabilityListener()
        FIRApp.configure()
        GMSPlacesClient.provideAPIKey(googleApiKey)
        GMSServices.provideAPIKey(googleApiKey)
        IQKeyboardManager.shared.enable = true
        UITabBar.appearance().tintColor = .themeColor
        UITabBar.appearance().unselectedItemTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        UITabBar.appearance().barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        UITabBar.appearance().isTranslucent = false
        self.setInitialViewController(from: "")
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        UIApplication.shared.applicationIconBadgeNumber = 0
        return true
    }
    func setInitialViewController(from:String) {
        if  from ==  "SignUp" {
            let storyboard = UIStoryboard( name: "Main", bundle: nil)
            let rootView: UINavigationController = storyboard.instantiateViewController(withIdentifier: "ProfileNavID") as! UINavigationController
            (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = rootView
            (UIApplication.shared.delegate as! AppDelegate).window?.makeKeyAndVisible()
        }else{
            if UserDefaults.standard.value(forKey: "driverInfo") != nil {
                let dic = TheGlobalPoolManager.retrieveFromDefaultsFor("driverInfo") as! NSDictionary
                let  driverDetails = JSON(dic)
                TheGlobalPoolManager.driverLoginModel = DriverLoginModel.init(fromJson: driverDetails)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let rootView: UINavigationController = storyboard.instantiateViewController(withIdentifier: "HomeNavigationID") as! UINavigationController
                (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = rootView
                (UIApplication.shared.delegate as! AppDelegate).window?.makeKeyAndVisible()
            }else{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller : UIViewController = storyboard.instantiateViewController(withIdentifier: "CustomLoginNavigationVCID")
                (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = controller
                (UIApplication.shared.delegate as! AppDelegate).window?.makeKeyAndVisible()
            }
        }
    }
    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) { }

    func applicationWillTerminate(_ application: UIApplication) { }
    
    func ReachabilityListener(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged),name: Notification.Name.reachabilityChanged,object: Reachability())
        do{
            let reachability = Reachability()!
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    @objc func reachabilityChanged(note: NSNotification){
        let reachability = note.object as! Reachability
        if reachability.connection != .none{
            IsInternetconnected=true
            if reachability.connection == .wifi{
                print("Reachable via WiFi")
            }else {
                print("Reachable via Cellular")
            }
        }else{
            IsInternetconnected=false
            print("Network not reachable")
        }
    }
}

