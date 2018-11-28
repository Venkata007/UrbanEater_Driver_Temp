//
//  AppDelegate.swift
//  UrbanEaterDriver
//
//  Created by Nagaraju on 01/11/18.
//  Copyright © 2018 Nagaraju. All rights reserved.
//

import UIKit

import GoogleMaps
import GooglePlaces
import Reachability

extension String {
    struct NumFormatter {
        static let instance = NumberFormatter()
    }
    
    var doubleValue: Double? {
        return NumFormatter.instance.number(from: self)?.doubleValue
    }
    
    var integerValue: Int? {
        return NumFormatter.instance.number(from: self)?.intValue
    }
}
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let googleApiKey = "AIzaSyAufQUMZP7qdjtOcGIuNFRSL-8uU6uuvGY"
    var IsInternetconnected:Bool=Bool()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
         self.ReachabilityListener()
        
        GMSPlacesClient.provideAPIKey(googleApiKey)
        GMSServices.provideAPIKey(googleApiKey)
        
        UITabBar.appearance().tintColor = .themeColor
        UITabBar.appearance().unselectedItemTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        UITabBar.appearance().barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        UITabBar.appearance().isTranslucent = false
        
        //self.setInitialViewController(from: "")
        
        return true
    }
    
    func setInitialViewController(from:String) {
        if  from ==  "SignUp"
        {
            
            let storyboard = UIStoryboard( name: "Main", bundle: nil)
            let rootView: UINavigationController = storyboard.instantiateViewController(withIdentifier: "ProfileNavID") as! UINavigationController
            (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = rootView
            (UIApplication.shared.delegate as! AppDelegate).window?.makeKeyAndVisible()
        }
            
        else{
            if UserDefaults.standard.value(forKey: "driverInfo") != nil
            {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let rootView: UINavigationController = storyboard.instantiateViewController(withIdentifier: "HomeNavigationID") as! UINavigationController
                (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = rootView
                (UIApplication.shared.delegate as! AppDelegate).window?.makeKeyAndVisible()
            }
            else
            {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller : UIViewController = storyboard.instantiateViewController(withIdentifier: "CustomLoginNavigationVCID")
                (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = controller
                (UIApplication.shared.delegate as! AppDelegate).window?.makeKeyAndVisible()
            }
            
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func ReachabilityListener()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged),name: Notification.Name.reachabilityChanged,object: Reachability())
        do{
            let reachability = Reachability()!
            
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    @objc func reachabilityChanged(note: NSNotification)
    {
        let reachability = note.object as! Reachability
        
        if reachability.connection != .none //reachability.isReachable
        {
            IsInternetconnected=true
            
            if reachability.connection == .wifi //reachability.isReachableViaWiFi
            {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        }
        else
        {
            IsInternetconnected=false
            print("Network not reachable")
        }
    }

}

