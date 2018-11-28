//
//  OrdersViewController.swift
//  DriverReadyToEat
//
//  Created by Nagaraju on 17/10/18.
//  Copyright © 2018 CasperonTechnologies. All rights reserved.
//

import UIKit
import JSSAlertView
import HTHorizontalSelectionList

class OrdersViewController: UIViewController,HTHorizontalSelectionListDelegate,HTHorizontalSelectionListDataSource {
    
    @IBOutlet weak var ordersTable: UITableView!
    @IBOutlet weak var selectionView: HTHorizontalSelectionList!
    
    var ordersList = [[String:Bool]]()
    var settings = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.updateUI()
    }
    override func viewWillDisappear(_ animated: Bool) {
        ordersList.removeAll()
    }
    //MARK:- Update UI
    func updateUI(){
        //Selection view...............
        selectionView.backgroundColor = .secondaryBGColor
        selectionView.selectionIndicatorAnimationMode = .heavyBounce
        selectionView.delegate = self
        selectionView.dataSource = self
        settings = ["Ongoing","Completed"]
        selectionView.centerButtons = true
        selectionView.selectionIndicatorColor = .themeColor
        selectionView.selectionIndicatorHeight = 3
        selectionView.bottomTrimColor = .clear
        selectionView.setTitleColor(.whiteColor, for: .normal)
        selectionView.setTitleColor(.whiteColor, for: .selected)
        selectionView.setTitleFont(.appFont(.Medium, size: 16), for: .normal)
        selectionView.setTitleFont(.appFont(.Medium, size: 16), for: .selected)
        selectionView.layer.masksToBounds = true
        self.selectionList(selectionView, didSelectButtonWith: 0)
        
        ordersTable.tableFooterView = UIView()
        ordersTable.delegate = self
        ordersTable.dataSource = self
    }
    //MARK : - HTHorizontalSelectionList Delegates
    func numberOfItems(in selectionList: HTHorizontalSelectionList) -> Int {
        return settings.count
    }
    func selectionList(_ selectionList: HTHorizontalSelectionList, titleForItemWith index: Int) -> String? {
        return (settings[index] as! String)
    }
    func selectionList(_ selectionList: HTHorizontalSelectionList, didSelectButtonWith index: Int) {
        switch selectionView.selectedButtonIndex {
        case 0:
            // Ongoing ....
            ordersTable.reloadData()
            break
        case 1:
            // Completed ....
            ordersTable.reloadData()
            break
        default:
            break
        }
    }
    //MARK : - Get Order API Hitting
    func getOrdersAPIcall(){
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
}
extension OrdersViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserDetailsCell") as! MoreTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
