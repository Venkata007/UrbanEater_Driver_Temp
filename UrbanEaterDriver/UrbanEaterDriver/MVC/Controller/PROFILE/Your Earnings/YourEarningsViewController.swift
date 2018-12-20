//
//  YourEarningsViewController.swift
//  DriverReadyToEat
//
//  Created by Nagaraju on 16/10/18.
//  Copyright © 2018 CasperonTechnologies. All rights reserved.
//

import UIKit
import SwiftyJSON

class YourEarningsViewController: UIViewController {

    @IBOutlet weak var fromDateView: UIView!
    @IBOutlet weak var toDateView: UIView!
    @IBOutlet weak var earningSTable: UITableView!
    @IBOutlet weak var fromDateLbl: UILabel!
    @IBOutlet weak var toDateLbl: UILabel!
    @IBOutlet weak var dateContainerView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var fromDateBtn: UIButton!
    @IBOutlet weak var todateBtn: UIButton!
    @IBOutlet weak var totalOrdersLbl: UILabel!
    @IBOutlet weak var totalEarningsLbl: UILabel!
    @IBOutlet weak var fromDateCalendarImg: UIImageView!
    @IBOutlet weak var toDateCalendarImg: UIImageView!
    
    var fromDateString : String!
    var toDateString : String!
    var dateSelectedString : String!
    var isFromDateSelected = false
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        earningSTable.register(UINib(nibName: "OrderCompletedCell", bundle: nil), forCellReuseIdentifier: "OrderCompletedCell")
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        earningSTable.tableFooterView = UIView()
        earningSTable.delegate = self
        earningSTable.dataSource = self
        self.fromDateCalendarImg.image = #imageLiteral(resourceName: "calendar").withColor(.secondaryTextColor)
        self.toDateCalendarImg.image = #imageLiteral(resourceName: "calendar").withColor(.secondaryTextColor)
        TheGlobalPoolManager.cornerAndBorder(fromDateView, cornerRadius: 5, borderWidth: 0.5, borderColor: .secondaryTextColor)
        TheGlobalPoolManager.cornerAndBorder(toDateView, cornerRadius: 5, borderWidth: 0.5, borderColor: .secondaryTextColor)
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        datePicker.setValue(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), forKeyPath: "textColor")
        datePicker.maximumDate = NSDate() as Date
        datePicker.maximumDate = Date()
        self.getEarningsHistoryApi()
        self.earningsDataApi()
    }
    //MARK:-  Earnings  Data  API Hitting
    func earningsDataApi(){
        Theme.sharedInstance.activityView(View: self.view)
        let param = [
                "driverId": TheGlobalPoolManager.driverLoginModel.data.subId!,
                "status": TheGlobalPoolManager.DELIVERED,
                "earningStatus" : 1] as [String : AnyObject]
        print(param)
        URLhandler.postUrlSession(urlString: Constants.urls.EarningsHistory, params: param as [String : AnyObject], header: [:]) { (dataResponse) in
            Theme.sharedInstance.removeActivityView(View: self.view)
            if dataResponse.json.exists(){
                TheGlobalPoolManager.earningsDataModel = EarningsDataModel.init(fromJson: dataResponse.json)
                self.totalOrdersLbl.text = TheGlobalPoolManager.earningsDataModel.data.earningData[0].totalOrderCount!.toString
                self.totalEarningsLbl.text = "₹ \(TheGlobalPoolManager.earningsDataModel.data.earningData[0].totalEarnAmount!.toString)"
            }
        }
    }
    //MARK:- Get Earnings  History  API Hitting
    func getEarningsHistoryApi(){
        Theme.sharedInstance.activityView(View: self.view)
        var param = [String : AnyObject]()
        if toDateString == nil{
            param = ["driverId": TheGlobalPoolManager.driverLoginModel.data.subId!,
                "status": TheGlobalPoolManager.DELIVERED] as [String : AnyObject]
        }else{
            param = [
                "driverId": TheGlobalPoolManager.driverLoginModel.data.subId!,
                "status": TheGlobalPoolManager.DELIVERED,
                "dateRange": [
                    "from": fromDateString,
                    "to": toDateString
                ]] as [String : AnyObject]
        }
        print(param)
        URLhandler.postUrlSession(urlString: Constants.urls.DriverOrders, params: param as [String : AnyObject], header: [:]) { (dataResponse) in
            Theme.sharedInstance.removeActivityView(View: self.view)
            if dataResponse.json.exists(){
                TheGlobalPoolManager.driverOrderModel = DriverOrderModel(fromJson: dataResponse.json)
                if TheGlobalPoolManager.driverOrderModel.data.count == 0{
                    self.earningSTable.isHidden = true
                    TheGlobalPoolManager.showAlertWith(message: "No data available", singleAction: true, callback: { (success) in
                        if success!{ }
                    })
                }else{
                    self.earningSTable.isHidden = false
                    self.earningSTable.reloadData()
                }
            }
        }
    }
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        dateSelectedString = dateFormatter.string(from: sender.date)
    }
    //MARK:- IB Action Outlets
    @IBAction func fromDateBtnClicked(_ sender: Any) {
        dateContainerView.isHidden = false
        blurView.isHidden = false
        isFromDateSelected = true
    }
    @IBAction func toDateBtnClicked(_ sender: Any) {
        if fromDateString == nil{
            TheGlobalPoolManager.showToastView("Please select from date first")
            return
        }
        dateContainerView.isHidden = false
        blurView.isHidden = false
        isFromDateSelected = false
    }
    @IBAction func datePickDoneClicked(_ sender: Any) {
        dateContainerView.isHidden = true
        blurView.isHidden = true
        print("dateSelectedString ---->>> \(dateSelectedString)")
        print("dateSelectedString ---->>> \(dateSelectedString)")
        let date = Date()
        if (dateSelectedString ?? "").isEmpty {
            dateSelectedString =  dateFormatter.string(from: date)
        }
        if isFromDateSelected {
            fromDateString = dateSelectedString
            fromDateLbl.text = dateSelectedString
            fromDateLbl.textColor = .textColor
        }else{
            toDateString = dateSelectedString
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date1 = dateFormatter.date(from: fromDateString)
            let date2 = dateFormatter.date(from: toDateString)
            if date1 == date2{
                toDateLbl.text = dateSelectedString
                toDateLbl.textColor = .textColor
                self.getEarningsHistoryApi()
            }else if date1! > date2! {
                TheGlobalPoolManager.showAlertWith(message: "Oops!, 'To Date' is past date when compared to 'From Date", singleAction: true, callback: { (success) in
                    if success!{}
                })
                return
            }else if date1! < date2! {
                toDateLbl.text = dateSelectedString
                toDateLbl.textColor = .textColor
                self.getEarningsHistoryApi()
            }
        }
    }
    @IBAction func datePickCancelClicked(_ sender: Any) {
         blurView.isHidden = true
        dateContainerView.isHidden = true
    }
    @IBAction func backBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension YourEarningsViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return TheGlobalPoolManager.driverOrderModel == nil ? 0 : TheGlobalPoolManager.driverOrderModel.data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
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
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewCon = self.storyboard?.instantiateViewController(withIdentifier: "OrderDetailsViewController") as! OrderDetailsViewController
        viewCon.driverOrderData = TheGlobalPoolManager.driverOrderModel.data[indexPath.row]
        
        self.navigationController?.pushViewController(viewCon, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
