//
//  YourEarningsViewController.swift
//  DriverReadyToEat
//
//  Created by Nagaraju on 16/10/18.
//  Copyright © 2018 CasperonTechnologies. All rights reserved.
//

import UIKit

class YourEarningsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var fromDateView: UIView!
    @IBOutlet weak var toDateView: UIView!
    @IBOutlet weak var earningSTable: UITableView!
    @IBOutlet weak var fromDateLbl: UILabel!
    @IBOutlet weak var toDateLbl: UILabel!
    @IBOutlet weak var dateContainerView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var blurView: UIView!
    
    var dateSelectedString : String!
    var isFromDateSelected = false
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fromDateView.layer.borderWidth = 1.0
        fromDateView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        toDateView.layer.borderWidth = 1.0
        toDateView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        let nibName = UINib(nibName:"EarningsTableViewCell" , bundle: nil)
        earningSTable.register(nibName, forCellReuseIdentifier: "EarningsTableViewCell")
        
        datePicker.datePickerMode = UIDatePickerMode.date
         datePicker.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
        dateFormatter.dateFormat = "dd/MM/yyyy"
    }
    
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
            fromDateLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }else{
            toDateLbl.text = dateSelectedString
            toDateLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    @IBAction func datePickCancelClicked(_ sender: Any) {
         blurView.isHidden = true
        dateContainerView.isHidden = true
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
//        dateFormatter.dateStyle = DateFormatter.Style.medium
//
//        dateFormatter.timeStyle = DateFormatter.Style.none
        
        dateSelectedString = dateFormatter.string(from: sender.date)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 6;//listMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : EarningsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EarningsTableViewCell") as! EarningsTableViewCell
        //cell.orderID_Lbl.text =
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orederInfo = self.storyboard?.instantiateViewController(withIdentifier: "OrderInfoViewControllerID") as! OrderInfoViewController
        self.navigationController?.pushViewController(orederInfo, animated: true)
    }

    @IBAction func backBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
