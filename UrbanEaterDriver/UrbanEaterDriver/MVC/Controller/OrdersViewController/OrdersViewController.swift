//
//  OrdersViewController.swift
//  DriverReadyToEat
//
//  Created by Nagaraju on 17/10/18.
//  Copyright © 2018 CasperonTechnologies. All rights reserved.
//

import UIKit
import JSSAlertView

class OrdersViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var ordersTable: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    var ordersList = [[String:Bool]]()
   // var sectionArr = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let ongoingNibName = UINib(nibName:"OngoingTableViewCell" , bundle: nil)
        ordersTable.register(ongoingNibName, forCellReuseIdentifier: "OngoingOrdersCell")
        
        let acceptedNibName = UINib(nibName:"AcceptedTableViewCell" , bundle: nil)
        ordersTable.register(acceptedNibName, forCellReuseIdentifier: "AcceptedOrdersCell")
        
        let completedNibName = UINib(nibName:"EarningsTableViewCell" , bundle: nil)
        ordersTable.register(completedNibName, forCellReuseIdentifier: "EarningsTableViewCell")
        
        let multiOrderNibName = UINib(nibName:"MultiOrderTableViewCell" , bundle: nil)
        ordersTable.register(multiOrderNibName, forCellReuseIdentifier: "MultiOrderCell")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        for _ in 1...6 {
            ordersList.append(["Accepted" : false])
        }
        
//        let ordersArr1:[[String:Bool]] = [["Accepted" : false],["Accepted" : false]]
//        let ordersArr2:[[String:Bool]] = [["Accepted" : false]]
//        let ordersArr3:[[String:Bool]] = [["Accepted" : false]]
//        let ordersArr4:[[String:Bool]] = [["Accepted" : false]]
//        let ordersArr5:[[String:Bool]] = [["Accepted" : false]]
//        let ordersArr6:[[String:Bool]] = [["Accepted" : false]]
//
//        sectionArr.append(ordersArr1)
//        sectionArr.append(ordersArr2)
//        sectionArr.append(ordersArr3)
//        sectionArr.append(ordersArr4)
//        sectionArr.append(ordersArr5)
//        sectionArr.append(ordersArr6)
//
        ordersTable.delegate = self
        ordersTable.dataSource = self
        
        
        ordersTable.sectionHeaderHeight = UITableViewAutomaticDimension;
        ordersTable.estimatedSectionHeaderHeight = 175;
        
        ordersTable.rowHeight = UITableViewAutomaticDimension
        ordersTable.estimatedRowHeight = 90;

      //  ordersTable = UITableView(frame: CGRect.zero, style: .grouped)
       // ordersTable = UITableView.init(frame: CGRect.zero, style: .grouped)
        self.ordersTable.reloadData()
    }
    
    @IBAction func segmentclicked(_ sender: UISegmentedControl) {
        self.ordersTable.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ordersList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if segmentControl.selectedSegmentIndex == 0 {
            if section == 0 {
                return 1
            }
        }
        return 0
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        print("estimatedHeightForRowAt ---->>")
//        return UITableViewAutomaticDimension
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//        
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if segmentControl.selectedSegmentIndex == 0 {
            
            let dictObj : NSDictionary = ordersList[section] as NSDictionary
            let isAccept : Bool = dictObj.object(forKey: "Accepted") as! Bool
            
            if section == 0 {
                // Multiple order cell
                let cell : MultiOrderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MultiOrderCell") as! MultiOrderTableViewCell
                // cell.pickupBtn.tag = section
                cell.navigationBtn.tag = section
                //cell.pickupBtn.addTarget(self, action: #selector(self.pressPickUpButton(_:)), for: .touchUpInside)
                cell.navigationBtn.addTarget(self, action: #selector(self.pressHeaderNavigationButton(_:)), for: .touchUpInside)
                
//                cell.separatorInset = UIEdgeInsets.zero
//                cell.layoutMargins = UIEdgeInsets.zero
                return cell;
            }
            else {
                // single order cell
                if !isAccept {
                    let cell : OngoingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "OngoingOrdersCell") as! OngoingTableViewCell
                    cell.acceptBtn.tag = section
                    cell.rejectBtn.tag = section
                    cell.acceptBtn.addTarget(self, action: #selector(self.pressSingleOrderAcceptButton(_:)), for: .touchUpInside)
                  //  cell.rejectBtn.addTarget(self, action: #selector(self.pressRejectButton(_:)), for: .touchUpInside)
                    
                    cell.separatorInset = UIEdgeInsets.zero
                    cell.layoutMargins = UIEdgeInsets.zero
                    return cell;
                    
                }else {
                    let cell : AcceptedTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AcceptedOrdersCell") as! AcceptedTableViewCell
                    
                    // cell.pickupBtn.tag = section
                    cell.navigationBtn.tag = section
                    //cell.pickupBtn.addTarget(self, action: #selector(self.pressPickUpButton(_:)), for: .touchUpInside)
                    cell.navigationBtn.addTarget(self, action: #selector(self.pressHeaderNavigationButton(_:)), for: .touchUpInside)
                    
                    cell.separatorInset = UIEdgeInsets.zero
                    cell.layoutMargins = UIEdgeInsets.zero
                    return cell;
                }
            }
            
        }else{
            let cell : EarningsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EarningsTableViewCell") as! EarningsTableViewCell
            //cell.orderID_Lbl.text =
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
            
            return cell;
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let dictObj : NSDictionary = ordersList[indexPath.section] as NSDictionary
        let isAccept : Bool = dictObj.object(forKey: "Accepted") as! Bool
        
        if indexPath.row == 0 {
            if !isAccept {
                let cell : OngoingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "OngoingOrdersCell") as! OngoingTableViewCell
                cell.topContraint.constant = 0
                cell.bottomContraint.constant = 0
                
                cell.restarantNameLbl.text = "Restaurant Name 02"
                cell.acceptBtn.tag = indexPath.section
                cell.rejectBtn.tag = indexPath.row
                cell.acceptBtn.addTarget(self, action: #selector(self.pressMultipleOrderAcceptButton(_:)), for: .touchUpInside)
               // cell.rejectBtn.addTarget(self, action: #selector(self.pressRejectButton(_:)), for: .touchUpInside)
                
                cell.separatorInset = UIEdgeInsets.zero
                cell.layoutMargins = UIEdgeInsets.zero
                
                return cell;
            }else{
                let cell : AcceptedTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AcceptedOrdersCell") as! AcceptedTableViewCell
                
                // cell.pickupBtn.tag = section
                cell.navigationBtn.tag = indexPath.row
                //cell.pickupBtn.addTarget(self, action: #selector(self.pressPickUpButton(_:)), for: .touchUpInside)
                cell.navigationBtn.addTarget(self, action: #selector(self.pressNavigationButton(_:)), for: .touchUpInside)
                
                cell.separatorInset = UIEdgeInsets.zero
                cell.layoutMargins = UIEdgeInsets.zero
                return cell;
            }
        }
        else {
            let cell : MultiOrderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MultiOrderCell") as! MultiOrderTableViewCell
            
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
            return cell;
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 10))
        footerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func pressPickUpButton(_ sender: UIButton) {
        print("PickUp btn clicked --->> \(sender.tag)")

        
    }
    
    @objc func pressHeaderNavigationButton(_ sender: UIButton) {
        print("Header Navigatio btn clicked --->> \(sender.tag)")
        moveToDirectionVC()
    }
    
    @objc func pressNavigationButton(_ sender: UIButton) {
        print("Navigation btn clicked --->> \(sender.tag)")
        moveToDirectionVC()
    }
    
    func moveToDirectionVC(){
        let directionVC = self.storyboard?.instantiateViewController(withIdentifier: "DirectionViewControllerID") as! DirectionViewController
        self.navigationController?.pushViewController(directionVC, animated: true)
    }
    
    @objc func pressMultipleOrderAcceptButton(_ sender: UIButton) {
         print("multiple orders accept btn clicked --->> \(sender.tag)")
        
        let message = "Are you sure you want to accept the order : ODD653"
        let alertview = JSSAlertView().show(self,title: "URBAN EATER",text: message,buttonText: "NO",cancelButtonText:"YES",color: #colorLiteral(red: 0, green: 0.7314415574, blue: 0.3181976676, alpha: 1))
        alertview.addAction {

            // self.switchOffline.setOn(false, animated: false)
            print("online ---->>> no")
        }
        
        alertview.addCancelAction{
            print("online ---->>> yes")
            self.ordersList[sender.tag] = ["Accepted":true]
            self.ordersTable.reloadData()
        }
    }
    
    @objc func pressSingleOrderAcceptButton(_ sender: UIButton) {
        print("Single order accept btn clicked --->> \(sender.tag)")
        let message = "Are you sure you want to accept the order : ODD653"
        let alertview = JSSAlertView().show(self,title: "URBAN EATER",text: message,buttonText: "NO",cancelButtonText:"YES",color: #colorLiteral(red: 0, green: 0.7314415574, blue: 0.3181976676, alpha: 1))
        alertview.addAction{
            
            // self.switchOffline.setOn(false, animated: false)
            print("online ---->>> no")
        }
        
        alertview.addCancelAction{
            print("online ---->>> yes")
            self.ordersList[sender.tag] = ["Accepted":true]
            self.ordersTable.reloadData()
        }
    }
    
//     func pressRejectButton(_ sender: UIButton) {
//        print("reject btn clicked --->> \(sender)")
//        let message = "Are you sure you want to reject the order : ODD653"
//        let alertview = JSSAlertView().showAlert(self,title: "URBAN EATER",text: message,buttonText: "NO",cancelButtonText:"YES",color: #colorLiteral(red: 0, green: 0.7314415574, blue: 0.3181976676, alpha: 1))
//        alertview.addAction({ action in
//
//            // self.switchOffline.setOn(false, animated: false)
//            print("online ---->>> no")
//        })
//
//        alertview.addCancelAction({ action in
//            print("online ---->>> yes")
//        })
//    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segmentControl.selectedSegmentIndex == 1 {
            let orederInfo = self.storyboard?.instantiateViewController(withIdentifier: "OrderInfoViewControllerID") as! OrderInfoViewController
            self.navigationController?.pushViewController(orederInfo, animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ordersList.removeAll()
    }
  
    
}
