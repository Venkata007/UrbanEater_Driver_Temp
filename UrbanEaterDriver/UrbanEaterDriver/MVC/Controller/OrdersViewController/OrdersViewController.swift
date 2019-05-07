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
        self.selectionList(selectionView, didSelectButtonWith: 0)
        
        ordersTable.tableFooterView = UIView()
        ordersTable.delegate = self
        ordersTable.dataSource = self
    }
    //MARK : - Pushing To Direction View Controller
    @objc func pushingToDirectionVC(_ sender: UIButton) {
        if let viewCon = self.storyboard?.instantiateViewController(withIdentifier: "DirectionViewController") as? DirectionViewController{
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
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
            self.getOrdersAPIcall(TheGlobalPoolManager.ON_GOING)
            break
        case 1:
            // Completed ....
            self.getOrdersAPIcall(TheGlobalPoolManager.DELIVERED)
            ordersTable.reloadData()
            break
        default:
            break
        }
    }
    //MARK:- Get Order API Hitting
    func getOrdersAPIcall(_ status : String){
        Theme.sharedInstance.activityView(View: self.view)
        let param = ["driverId": TheGlobalPoolManager.driverLoginModel.data.subId!,
                                "status": status]
        URLhandler.postUrlSession(urlString: Constants.urls.DriverOrders, params: param as [String : AnyObject], header: [:]) { (dataResponse) in
            Theme.sharedInstance.removeActivityView(View: self.view)
            if dataResponse.json.exists(){
                TheGlobalPoolManager.driverOrderModel = DriverOrderModel(fromJson: dataResponse.json)
                if TheGlobalPoolManager.driverOrderModel.data.count == 0{
                    self.ordersTable.isHidden = true
                    TheGlobalPoolManager.showToastView(ToastMessages.No_Data_Available)
                }else{
                    self.ordersTable.isHidden = false
                    self.ordersTable.reloadData()
                }
            }
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
    //MARK : - Status Button Method
    @objc func statusBtnMethod(_ btn : UIButton){
        var statusCode = ""
        switch btn.tag {
        case 0:
            let data = TheGlobalPoolManager.driverOrderModel.data[0].order[0]
            statusCode = data.code!
        case 1:
            let data = TheGlobalPoolManager.driverOrderModel.data[0]
            statusCode = data.code!.toString
        default:
            break
        }
        TheGlobalPoolManager.showAlertWith(message: "Code : \(statusCode)", singleAction: true) { (success) in
            if success!{}
        }
    }
    //MARK : - Direction Button Method
    @objc func directionBtnMethod(_ btn : UIButton){
        var latitude = ""
        var longitude = ""
        switch btn.tag {
        case 0:
            let data = TheGlobalPoolManager.driverOrderModel.data[0].order[0]
            let resData = TheGlobalPoolManager.driverOrderModel.data[0].restaurantIdData.filter { (details) -> Bool in
                return data.restaurantId == details.id
                }[0]
            latitude = String(resData.loc.lat!)
            longitude = String(resData.loc.lng!)
        case 1:
            let data = TheGlobalPoolManager.driverOrderModel.data[0].order[1]
            let resData = TheGlobalPoolManager.driverOrderModel.data[0].restaurantIdData.filter { (details) -> Bool in
                return data.restaurantId == details.id
                }[0]
            latitude = String(resData.loc.lat!)
            longitude = String(resData.loc.lng!)
        case 2:
            let data = TheGlobalPoolManager.driverOrderModel.data[0].loc!
            latitude = String(data.lat!)
            longitude = String(data.lng!)
        default:
            break
        }
        if let url = URL(string: "comgooglemaps://?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving") {
            UIApplication.shared.open(url, options: [:])
        }else {
            NSLog("Can't use comgooglemaps://");
            UIApplication.shared.open(URL(string: "http://maps.google.com/maps?q=loc:\(latitude),\(longitude)&zoom=14&views=traffic")!, options: [:], completionHandler: nil)
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
            if TheGlobalPoolManager.driverOrderModel != nil{
                if TheGlobalPoolManager.driverOrderModel.data.count != 0{
                    if TheGlobalPoolManager.driverOrderModel.data[0].order.count == 2{
                        return 3
                    }else{
                        return 2
                    }
                }
            }
            return 0
        case 1:
            return TheGlobalPoolManager.driverOrderModel == nil ? 0 : TheGlobalPoolManager.driverOrderModel.data.count
        default:
            break
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        switch selectionView.selectedButtonIndex {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OngoingTableViewCell") as! OngoingTableViewCell
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            if TheGlobalPoolManager.driverOrderModel.data[0].order.count == 2{
                if indexPath.row == 0{
                    cell.collectionView.tag = 111
                    cell.directionBtn.tag = 0
                    cell.statusBtn.tag = 0
                    cell.directionBtn.addTarget(self, action: #selector(directionBtnMethod(_:)), for: .touchUpInside)
                    cell.statusBtn.addTarget(self, action: #selector(statusBtnMethod(_:)), for: .touchUpInside)
                    let data = TheGlobalPoolManager.driverOrderModel.data[0].order[0]
                    let resData = TheGlobalPoolManager.driverOrderModel.data[0].restaurantIdData.filter { (details) -> Bool in
                        return data.restaurantId == details.id
                        }[0]
                    cell.callBtn.isHidden = true
                    cell.restaurantNameLbl.text = resData.name!
                    cell.idLbl.text = data.subOrderId!
                    cell.addressLbl.text = resData.address.fulladdress!
                    cell.statusBtn.setTitle(data.statusText!, for: .normal)
                    ez.runThisInMainThread {
                        cell.directionBtnWidth.constant = 50
                        cell.directionBtnHeight.constant = 50
                    }
                }else if indexPath.row == 1{
                    cell.collectionView.tag = 222
                    cell.directionBtn.tag = 1
                    cell.statusBtn.tag = 1
                    cell.directionBtn.addTarget(self, action: #selector(directionBtnMethod(_:)), for: .touchUpInside)
                    cell.statusBtn.addTarget(self, action: #selector(statusBtnMethod(_:)), for: .touchUpInside)
                    let data = TheGlobalPoolManager.driverOrderModel.data[0].order[1]
                    let resData = TheGlobalPoolManager.driverOrderModel.data[0].restaurantIdData.filter { (details) -> Bool in
                        return data.restaurantId == details.id
                        }[0]
                    cell.callBtn.isHidden = true
                    cell.restaurantNameLbl.text = resData.name!
                    cell.idLbl.text = data.subOrderId!
                    cell.addressLbl.text = resData.address.fulladdress!
                    cell.statusBtn.setTitle(data.statusText!, for: .normal)
                    ez.runThisInMainThread {
                        cell.directionBtnWidth.constant = 50
                        cell.directionBtnHeight.constant = 50
                    }
                }else if indexPath.row == 2{
                    cell.collectionView.tag = 333
                    cell.directionBtn.tag = 2
                    cell.callBtn.tag = 2
                    cell.statusBtn.tag = 2
                    cell.directionBtn.addTarget(self, action: #selector(directionBtnMethod(_:)), for: .touchUpInside)
                    cell.statusBtn.addTarget(self, action: #selector(statusBtnMethod(_:)), for: .touchUpInside)
                    cell.callBtn.addTarget(self, action: #selector(callBtnMethod(_:)), for: .touchUpInside)
                    cell.restaurantNameLbl.text = "Delivery Location"
                    let data = TheGlobalPoolManager.driverOrderModel.data[0]
                    cell.idLbl.text = data.orderId!
                    cell.addressLbl.text = data.address.fulladdress!
                    cell.statusBtn.setTitle(data.statusText!, for: .normal)
                    ez.runThisInMainThread {
                        cell.directionBtnWidth.constant = 40
                        cell.directionBtnHeight.constant = 40
                    }
                }
                return cell
            }else{
                if indexPath.row == 0{
                    cell.collectionView.tag = 111
                    cell.directionBtn.tag = 0
                    cell.statusBtn.tag = 0
                    cell.directionBtn.addTarget(self, action: #selector(directionBtnMethod(_:)), for: .touchUpInside)
                    cell.statusBtn.addTarget(self, action: #selector(statusBtnMethod(_:)), for: .touchUpInside)
                    let data = TheGlobalPoolManager.driverOrderModel.data[0].order[0]
                    let resData = TheGlobalPoolManager.driverOrderModel.data[0].restaurantIdData.filter { (details) -> Bool in
                        return data.restaurantId == details.id
                        }[0]
                    cell.callBtn.isHidden = true
                    cell.restaurantNameLbl.text = resData.name!
                    cell.idLbl.text = data.subOrderId!
                    cell.addressLbl.text = resData.address.fulladdress!
                    cell.statusBtn.setTitle(data.statusText!, for: .normal)
                    ez.runThisInMainThread {
                        cell.directionBtnWidth.constant = 50
                        cell.directionBtnHeight.constant = 50
                    }
                    return cell
                }else if indexPath.row == 1{
                    cell.collectionView.tag = 333
                    cell.directionBtn.tag = 2
                    cell.callBtn.tag = 2
                    cell.statusBtn.tag = 2
                    cell.directionBtn.addTarget(self, action: #selector(directionBtnMethod(_:)), for: .touchUpInside)
                    cell.statusBtn.addTarget(self, action: #selector(statusBtnMethod(_:)), for: .touchUpInside)
                    cell.callBtn.addTarget(self, action: #selector(callBtnMethod(_:)), for: .touchUpInside)
                    cell.restaurantNameLbl.text = "Delivery Location"
                    let data = TheGlobalPoolManager.driverOrderModel.data[0]
                    cell.idLbl.text = data.orderId!
                    cell.addressLbl.text = data.address.fulladdress!
                    cell.statusBtn.setTitle(data.statusText!, for: .normal)
                    ez.runThisInMainThread {
                        cell.directionBtnWidth.constant = 40
                        cell.directionBtnHeight.constant = 40
                    }
                    return cell
                }
            }
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCompletedCell") as! OrderCompletedCell
            let data1 = TheGlobalPoolManager.driverOrderModel.data[indexPath.row]
            cell.orderIDLbl.text = "Order ID: \(data1.orderId!)"
            cell.amountLbl.text = "₹ \(data1.billing.orderTotal!)"
            cell.statusLbl.text = data1.statusText!
            let data = TheGlobalPoolManager.driverOrderModel.data[indexPath.row].order
            var resName = ""
            for d in data!{
                let resData = TheGlobalPoolManager.driverOrderModel.data[indexPath.row].restaurantIdData.filter { (details) -> Bool in
                    return d.restaurantId == details.id
                    }[0]
                if resName.length == 0{
                    resName = resData.name! + " - \(d.subOrderId!)"
                }else{
                    resName = resName + "\n" + resData.name! + " - \(d.subOrderId!)"
                }
            }
            cell.restaurantName.text = resName
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
            let orederInfo = self.storyboard?.instantiateViewController(withIdentifier: "OrderDetailsViewController") as! OrderDetailsViewController
            orederInfo.driverOrderData = TheGlobalPoolManager.driverOrderModel.data[indexPath.row]
            self.navigationController?.pushViewController(orederInfo, animated: true)
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
            if TheGlobalPoolManager.driverOrderModel != nil{
                if TheGlobalPoolManager.driverOrderModel.data.count != 0{
                    headerCell.orderID.text = TheGlobalPoolManager.driverOrderModel.data[0].orderId!
                    headerCell.amountLbl.text = "COD     ₹\(String(TheGlobalPoolManager.driverOrderModel.data[0].billing.grandTotal!))"
                }else{
                    headerCell.orderID.text = ""
                    headerCell.amountLbl.text = ""
                }
            }
            return headerCell.contentView
        }
        return nil
    }
}
extension OrdersViewController : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let data = TheGlobalPoolManager.driverOrderModel.data[0].items
        if collectionView.tag == 111{
            let data = TheGlobalPoolManager.driverOrderModel.data[0].order[0]
            let resData = TheGlobalPoolManager.driverOrderModel.data[0].items.filter { (details) -> Bool in
                return data.restaurantId == details.restaurantId
                }
               return resData.count
        }else if collectionView.tag == 222{
            let data = TheGlobalPoolManager.driverOrderModel.data[0].order[1]
            let resData = TheGlobalPoolManager.driverOrderModel.data[0].items.filter { (details) -> Bool in
                return data.restaurantId == details.restaurantId
            }
            return resData.count
        }else{
            return (data?.count)!
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnGoingDishesCell", for: indexPath as IndexPath) as! OnGoingDishesCell
        if collectionView.tag == 111{
            let data = TheGlobalPoolManager.driverOrderModel.data[0].order[0]
            let resData = TheGlobalPoolManager.driverOrderModel.data[0].items.filter { (details) -> Bool in
                return data.restaurantId == details.restaurantId
            }
            cell.contentLbl.text = resData[indexPath.row].name!
            cell.itemsCountLbl.text = "✕\(resData[indexPath.row].quantity!)"
            if resData[indexPath.row].vorousType! == 0{
                cell.vegStausImg.image = #imageLiteral(resourceName: "Non_Veg")
            }else{
                cell.vegStausImg.image = #imageLiteral(resourceName: "Veg")
            }
        }else if collectionView.tag == 222{
            let data = TheGlobalPoolManager.driverOrderModel.data[0].order[1]
            let resData = TheGlobalPoolManager.driverOrderModel.data[0].items.filter { (details) -> Bool in
                return data.restaurantId == details.restaurantId
            }
            cell.contentLbl.text = resData[indexPath.row].name!
            cell.itemsCountLbl.text = "✕\(resData[indexPath.row].quantity!)"
            if resData[indexPath.row].vorousType! == 1{
                cell.vegStausImg.image = #imageLiteral(resourceName: "Non_Veg")
            }else{
                cell.vegStausImg.image = #imageLiteral(resourceName: "Veg")
            }
        }else{
            let resData = TheGlobalPoolManager.driverOrderModel.data[0].items!
            cell.contentLbl.text = resData[indexPath.row].name!
            cell.itemsCountLbl.text = "✕\(resData[indexPath.row].quantity!)"
            if resData[indexPath.row].vorousType! == 1{
                cell.vegStausImg.image = #imageLiteral(resourceName: "Non_Veg")
            }else{
                cell.vegStausImg.image = #imageLiteral(resourceName: "Veg")
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
    }
}

