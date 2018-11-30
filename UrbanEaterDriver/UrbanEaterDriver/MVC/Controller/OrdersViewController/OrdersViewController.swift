//
//  OrdersViewController.swift
//  DriverReadyToEat
//
//  Created by Nagaraju on 17/10/18.
//  Copyright © 2018 CasperonTechnologies. All rights reserved.
//

import UIKit
import HTHorizontalSelectionList
import EZSwiftExtensions

class OrdersViewController: UIViewController,HTHorizontalSelectionListDelegate,HTHorizontalSelectionListDataSource {
    
    @IBOutlet weak var ordersTable: UITableView!
    @IBOutlet weak var selectionView: HTHorizontalSelectionList!
    
    var settings = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ordersTable.register(UINib(nibName: "OngoingTableViewCell", bundle: nil), forCellReuseIdentifier: "OngoingTableViewCell")
        ordersTable.register(UINib(nibName: "OngoingHeaderCell", bundle: nil), forCellReuseIdentifier: "OngoingHeaderCell")
        ordersTable.register(UINib(nibName: "OrderCompletedCell", bundle: nil), forCellReuseIdentifier: "OrderCompletedCell")
        self.updateUI()
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
        //self.selectionList(selectionView, didSelectButtonWith: 0)
        
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
    //MARK:- Get Order API Hitting
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
    //MARK : - Direction Button Method
    @objc func directionBtnMethod(_ btn : UIButton){
        let latitude = "17.437462"
        let longitude = "78.448288"
        if let url = URL(string: "comgooglemaps://?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving") {
            UIApplication.shared.open(url, options: [:])
        }else if let url = URL(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(String(describing: latitude)),\(String(describing: longitude))") {
            UIApplication.shared.open(url, options: [:])
        }else{
            print("Can't use comgooglemaps://")
        }
    }
    //MARK : - Call Button Method
    @objc func callBtnMethod(_ btn : UIButton){
        let phoneNumber = "9533565007"
        if let phoneCallURL = URL(string: "telprompt://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(phoneCallURL as URL)
                }
            }
        }
    }
    //MARK : - Show Completed Order Details XIB
    func showCompletedOrderDetailsXib(){
        let viewCon = OrderCompletedDetailsView(nibName: "OrderCompletedDetailsView", bundle: nil)
        TheGlobalPoolManager.cornerAndBorder(viewCon.view, cornerRadius: 10, borderWidth: 0, borderColor: .clear)
        self.presentPopupViewController(viewCon, animationType: MJPopupViewAnimationSlideTopTop)
    }
}
extension OrdersViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectionView.selectedButtonIndex {
        case 0:
            return 3
        case 1:
            return 4
        default:
            break
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        switch selectionView.selectedButtonIndex {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OngoingTableViewCell") as! OngoingTableViewCell
            cell.collectionView.tag = 0
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            if indexPath.row == 0{
                cell.callBtn.isHidden = true
                ez.runThisInMainThread {
                    cell.directionBtnWidth.constant = 50
                    cell.directionBtnHeight.constant = 50
                }
            }else if indexPath.row == 1{
                cell.restaurantNameLbl.text = "Restaurant Name 02"
                ez.runThisInMainThread {
                    cell.directionBtnWidth.constant = 50
                    cell.directionBtnHeight.constant = 50
                }
                cell.callBtn.isHidden = true
            }else if indexPath.row == 2{
                cell.directionBtnWidth.constant = 40
                cell.directionBtnHeight.constant = 40
                cell.restaurantNameLbl.text = "Delivery Location"
            }
            cell.directionBtn.tag = indexPath.row
            cell.callBtn.tag = indexPath.row
            cell.directionBtn.addTarget(self, action: #selector(directionBtnMethod(_:)), for: .touchUpInside)
            cell.callBtn.addTarget(self, action: #selector(callBtnMethod(_:)), for: .touchUpInside)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCompletedCell") as! OrderCompletedCell
            return cell
        default:
            break
        }
       return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectionView.selectedButtonIndex == 0{
            print(indexPath.row)
        }else{
            self.showCompletedOrderDetailsXib()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch selectionView.selectedButtonIndex {
        case 0:
            return 275
        case 1:
            return UITableViewAutomaticDimension
        default:
            break
        }
        return 0
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch selectionView.selectedButtonIndex {
        case 0:
            return 275
        case 1:
            return UITableViewAutomaticDimension
        default:
            break
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if selectionView.selectedButtonIndex == 0{
            return 50
        }
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if selectionView.selectedButtonIndex == 0{
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "OngoingHeaderCell") as! OngoingHeaderCell
            return headerCell.contentView
        }
        return nil
    }
}
extension OrdersViewController : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnGoingDishesCell", for: indexPath as IndexPath) as! OnGoingDishesCell
        if indexPath.row % 2 == 0{
            cell.vegStausImg.image = #imageLiteral(resourceName: "Non_Veg")
            cell.contentLbl.text = "Mutton Biryani"
        }else if indexPath.row == 0{
            cell.vegStausImg.image = #imageLiteral(resourceName: "Veg")
            cell.contentLbl.text = "Veg Biryani"
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
    }
}

