//
//  NotificationViewController.swift
//  DriverReadyToEat
//
//  Created by Nagaraju on 17/10/18.
//  Copyright © 2018 CasperonTechnologies. All rights reserved.
//

import UIKit
import SwiftyJSON

class NotificationViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        dummyData()
    }
    
    func dummyData(){
        
        let dictinary = [
            "statusCode": 200,
            "name": "SUCCESS_OK",
            "message": "Logged in successfully",
            "code": 1500,
            "data": ["notifications":[
                ["title":"New offer",
                "description":"Lorem Ipem is 123 simply dummy text of the printing and typesetting industry. Lorem ipsum has"],
                ["title":"Combo offer",
                "description":"Lorem Ipem is 456 simply dummy text of the printing and typesetting industry. Lorem ipsum has"]]
            ]] as [String:Any]
        
        let response = JSON(dictinary)
        TheGlobalPoolManager.notificationModel = NotofocationModel(fromJson: response)
    }
    
    func getNotificationsAPIcall(){
        Theme.sharedInstance.activityView(View: self.view)

        print("urlStr ----->>> ", Constants.urls.notificationsURL)

        URLhandler.getUrlSession(urlString: Constants.urls.notificationsURL, params: [:], header: [:]) { (dataResponse) in
            print("Response ----->>> ", dataResponse.json)
            Theme.sharedInstance.removeActivityView(View: self.view)
            if dataResponse.json.exists(){
                TheGlobalPoolManager.earningModel = EarningModel(dataResponse.json)
                
            }
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return TheGlobalPoolManager.notificationModel.data.Notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : NotificationTableViewCell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell") as! NotificationTableViewCell
        
        let notify = TheGlobalPoolManager.notificationModel.data.Notifications[indexPath.row]
        cell.titleLbl.text = notify.title
        cell.descLbl.text = notify.description

        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 85
        
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
