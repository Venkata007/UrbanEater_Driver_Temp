//
//  OrderInfoViewController.swift
//  DriverReadyToEat
//
//  Created by Nagaraju on 17/10/18.
//  Copyright © 2018 CasperonTechnologies. All rights reserved.
//

import UIKit

class OrderInfoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
@IBOutlet weak var ordersInfoTable: UITableView!
    var isExpanded = false
    var orderList = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ordersInfoTable.register(UINib(nibName:"OrderInfoTableViewCell1" , bundle: nil), forCellReuseIdentifier: "OrderInfoCell1")
        ordersInfoTable.register(UINib(nibName:"OrderInfoTableViewCell2" , bundle: nil), forCellReuseIdentifier: "OrderInfoCell2")
        ordersInfoTable.register(UINib(nibName:"OrderInfoTableViewCell3" , bundle: nil), forCellReuseIdentifier: "OrderInfoCell3")
        ordersInfoTable.register(UINib(nibName:"OrderInfoTableViewCell4" , bundle: nil), forCellReuseIdentifier: "OrderInfoCell4")
        
        orderList = ["a","b","c"]
        ordersInfoTable.delegate = self
        ordersInfoTable.dataSource = self
        ordersInfoTable.tableFooterView = UIView()
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.row == 0 {
            let cell : OrderInfoTableViewCell1 = tableView.dequeueReusableCell(withIdentifier: "OrderInfoCell1") as! OrderInfoTableViewCell1
            //cell.orderID_Lbl.text =
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
            return cell;
        }
        else if indexPath.row == 1 {
            let cell : OrderInfoTableViewCell2 = tableView.dequeueReusableCell(withIdentifier: "OrderInfoCell2") as! OrderInfoTableViewCell2
            //cell.orderID_Lbl.text =
            cell.headerLbl.text = "Pickup Address"
            cell.nameLbl.text = "Greeley Bar And Grilled"
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
            return cell;
        }
        else if indexPath.row == 2 {
            let cell : OrderInfoTableViewCell2 = tableView.dequeueReusableCell(withIdentifier: "OrderInfoCell2") as! OrderInfoTableViewCell2
            cell.headerLbl.text = "Delivery Address"
            cell.nameLbl.text = "Henry Francis"
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
            return cell;
        }
        else if indexPath.row == 3 {
            let cell : OrderInfoTableViewCell3 = tableView.dequeueReusableCell(withIdentifier: "OrderInfoCell3") as! OrderInfoTableViewCell3
            cell.OrdersCollectionView.delegate = self
            cell.OrdersCollectionView.dataSource = self
            cell.OrdersCollectionView.reloadData()
            cell.headerBtn.tag = indexPath.row
            cell.headerBtn.addTarget(self, action: #selector(self.pressHeaderExpandButton(_:)), for: .touchUpInside)
            if isExpanded {
                cell.arrowImg.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2.0) // down
                cell.deviderViewHeightContraint.constant = 1
            }else{
                cell.arrowImg.transform = CGAffineTransform.identity // cross
                cell.deviderViewHeightContraint.constant = 0
                
            }
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
            return cell;
        }
        else  {
            let cell : OrderInfoTableViewCell4 = tableView.dequeueReusableCell(withIdentifier: "OrderInfoCell4") as! OrderInfoTableViewCell4
            //cell.orderID_Lbl.text =
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
            return cell;
        }

    }
    
    @objc func pressHeaderExpandButton(_ sender: UIButton){
        let indexPath = IndexPath(item: sender.tag, section: 0)
       // let cell = ordersInfoTable.cellForRow(at: indexPath) as! OrderInfoTableViewCell3
        
        if isExpanded {
            isExpanded = false
            ordersInfoTable.reloadRows(at: [indexPath], with: .bottom)
        }else{
            isExpanded = true
            ordersInfoTable.reloadRows(at: [indexPath], with: .top)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 { // 139 133
            return 139
        } else if indexPath.row == 1 || indexPath.row == 2 { // 139 133
            return 133
        }else if indexPath.row == 3 { // 139 133
            if isExpanded {
                return CGFloat(60 + (33*orderList.count))//130
            }
            return 50
        }else{
            return 220
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            
        }
    }

    @IBAction func backBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

extension OrderInfoViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orderList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderCollectionViewCell", for: indexPath as IndexPath) as! OrderCollectionViewCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected Index >>>>>>>",indexPath.row)
    }
}
