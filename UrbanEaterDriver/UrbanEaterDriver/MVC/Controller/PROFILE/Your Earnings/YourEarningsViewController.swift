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
        dateFormatter.dateFormat = "dd/MM/yyyy"
        datePicker.setValue(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), forKeyPath: "textColor")
    }
    func getEarningsAPIcall(){
        Theme.sharedInstance.activityView(View: self.view)
        let param = [
            "from": fromDateLbl.text,
            "to": toDateLbl.text,
            "through": "WEB"
        ]
        print("urlStr ----->>> ", Constants.urls.loginURL)
        print("param request ----->>> ", param)
        
        URLhandler.postUrlSession(urlString: Constants.urls.earningsURL, params: param as [String : AnyObject], header: [:]) { (dataResponse) in
            print("Response login ----->>> ", dataResponse.json)
            Theme.sharedInstance.removeActivityView(View: self.view)
            if dataResponse.json.exists(){
                TheGlobalPoolManager.earningModel = EarningModel(dataResponse.json)
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
        dateContainerView.isHidden = false
        blurView.isHidden = false
        isFromDateSelected = false
    }
    @IBAction func datePickDoneClicked(_ sender: Any) {
        dateContainerView.isHidden = true
        blurView.isHidden = true
        print("dateSelectedString ---->>> \(dateSelectedString)")
        let date = Date()
        if (dateSelectedString ?? "").isEmpty {
            dateSelectedString =  dateFormatter.string(from: date)
        }
        if isFromDateSelected {
            fromDateLbl.text = dateSelectedString
            fromDateLbl.textColor = .textColor
        }else{
            toDateLbl.text = dateSelectedString
            toDateLbl.textColor = .textColor
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
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell : OrderCompletedCell = tableView.dequeueReusableCell(withIdentifier: "OrderCompletedCell") as! OrderCompletedCell
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orederInfo = self.storyboard?.instantiateViewController(withIdentifier: "OrderDetailsViewController") as! OrderDetailsViewController
        self.navigationController?.pushViewController(orederInfo, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
