//
//  NotificationViewController.swift
//  DriverReadyToEat
//
//  Created by Nagaraju on 17/10/18.
//  Copyright © 2018 CasperonTechnologies. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
    }
    //MARK:- IB Action Outlets
    func getNotificationsAPIcall(){
        Theme.sharedInstance.activityView(View: self.view)
        print("urlStr ----->>> ", Constants.urls.loginURL)
        URLhandler.getUrlSession(urlString: Constants.urls.loginURL, params: [:], header: [:]) { (dataResponse) in
            print("Response ----->>> ", dataResponse.json)
            Theme.sharedInstance.removeActivityView(View: self.view)
            if dataResponse.json.exists(){
                //TheGlobalPoolManager.earningModel = EarningModel(dataResponse.json)
            }
        }
    }
}
extension NotificationViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell : NotificationTableViewCell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell") as! NotificationTableViewCell
        cell.titleLbl.text = "Notification 0\(indexPath.row + 1)"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
