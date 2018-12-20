//
//  OrderDetailsViewController.swift
//  UrbanEaterDriver
//
//  Created by Venkat@Hexadots on 30/11/18.
//  Copyright © 2018 Nagaraju. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class OrderDetailsViewController: UIViewController {
    
    @IBOutlet weak var backBtn : UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var driverOrderData : DriverOrderData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "OngoingTableViewCell", bundle: nil), forCellReuseIdentifier: "OngoingTableViewCell")
        tableView.register(UINib(nibName: "OngoingHeaderCell", bundle: nil), forCellReuseIdentifier: "OngoingHeaderCell")
        tableView.register(UINib(nibName:"OrderInfoTableViewCell4" , bundle: nil), forCellReuseIdentifier: "OrderInfoCell4")
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }
    //MARK:- IB Action Outlets
    @IBAction func backBtn(_ sender: UIButton) {
        ez.topMostVC?.popVC()
    }
}
extension OrderDetailsViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if driverOrderData != nil{
            if driverOrderData.order.count == 2{
                return 4
            }else{
                return 3
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if driverOrderData.order.count == 2{
            if indexPath.row == 3{
                let cell = tableView.dequeueReusableCell(withIdentifier: "OrderInfoCell4") as! OrderInfoTableViewCell4
                let data = driverOrderData.billing!
                cell.subTotal.text = data.orderTotal!.toString
                cell.restautarantOfferLbl.text = data.couponDiscount!.toString
                cell.deliveryFeeLbl.text = data.deliveryCharge!.toString
                cell.taxLbl.text = data.serviceTax!.toString
                cell.yourEarningsLbl.text = String(data.grandTotal!)
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "OngoingTableViewCell") as! OngoingTableViewCell
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.callBtn.isHidden = true
            cell.directionBtn.isHidden = true
            if indexPath.row == 0{
                cell.collectionView.tag = 111
                let data = driverOrderData.order[0]
                let resData = driverOrderData.restaurantIdData.filter { (details) -> Bool in
                    return data.restaurantId == details.id
                    }[0]
                cell.restaurantNameLbl.text = resData.name!
                cell.idLbl.text = data.subOrderId!
                cell.addressLbl.text = resData.address.fulladdress!
                cell.statusBtn.setTitle(data.statusText!, for: .normal)
                return cell
            }else if indexPath.row == 1{
                cell.collectionView.tag = 222
                let data = driverOrderData.order[1]
                let resData = driverOrderData.restaurantIdData.filter { (details) -> Bool in
                    return data.restaurantId == details.id
                    }[0]
                cell.restaurantNameLbl.text = resData.name!
                cell.idLbl.text = data.subOrderId!
                cell.addressLbl.text = resData.address.fulladdress!
                cell.statusBtn.setTitle(data.statusText!, for: .normal)
                return cell
            }else if indexPath.row == 2{
                cell.collectionView.tag = 333
                let data = driverOrderData!
                cell.idLbl.text = data.orderId!
                cell.addressLbl.text = data.address.fulladdress!
                cell.statusBtn.setTitle(data.statusText!, for: .normal)
            }
            cell.statusBtn.backgroundColor = .greenColor
            return cell
        }else{
            if indexPath.row == 2{
                let cell = tableView.dequeueReusableCell(withIdentifier: "OrderInfoCell4") as! OrderInfoTableViewCell4
                let data = driverOrderData.billing!
                cell.subTotal.text = data.orderTotal!.toString
                cell.restautarantOfferLbl.text = data.couponDiscount!.toString
                cell.deliveryFeeLbl.text = data.deliveryCharge!.toString
                cell.taxLbl.text = data.serviceTax!.toString
                cell.yourEarningsLbl.text = String(data.grandTotal!)
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "OngoingTableViewCell") as! OngoingTableViewCell
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.callBtn.isHidden = true
            cell.directionBtn.isHidden = true
            if indexPath.row == 0{
                cell.collectionView.tag = 111
                let data = driverOrderData.order[0]
                let resData = driverOrderData.restaurantIdData.filter { (details) -> Bool in
                    return data.restaurantId == details.id
                    }[0]
                cell.restaurantNameLbl.text = resData.name!
                cell.idLbl.text = data.subOrderId!
                cell.addressLbl.text = resData.address.fulladdress!
                cell.statusBtn.setTitle(data.statusText!, for: .normal)
            }else if indexPath.row == 1{
                cell.collectionView.tag = 333
                cell.restaurantNameLbl.text = "Delivery Location"
                let data = driverOrderData!
                cell.idLbl.text = data.orderId!
                cell.addressLbl.text = data.address.fulladdress!
                cell.statusBtn.setTitle(data.statusText!, for: .normal)
            }
            cell.statusBtn.backgroundColor = .greenColor
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if driverOrderData != nil{
            if driverOrderData.order.count == 2{
                if indexPath.row == 3{
                    return 220
                }
                return 275
            }else{
                if indexPath.row == 2{
                    return 220
                }
                return 275
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "OngoingHeaderCell") as! OngoingHeaderCell
        if driverOrderData != nil{
            headerCell.orderID.text = "Order ID: \(driverOrderData.orderId!)"
            headerCell.amountLbl.text = "Code    ₹\(driverOrderData.billing.grandTotal!)"
        }
        return headerCell.contentView
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
extension OrderDetailsViewController : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let data = driverOrderData.items
        if collectionView.tag == 111{
            let data = driverOrderData.order[0]
            let resData = driverOrderData.items.filter { (details) -> Bool in
                return data.restaurantId == details.restaurantId
            }
            return resData.count
        }else if collectionView.tag == 222{
            let data = driverOrderData.order[1]
            let resData = driverOrderData.items.filter { (details) -> Bool in
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
            let data = driverOrderData.order[0]
            let resData = driverOrderData.items.filter { (details) -> Bool in
                return data.restaurantId == details.restaurantId
            }
            cell.contentLbl.text = resData[indexPath.row].name!
            cell.itemsCountLbl.text = "✕\(resData[indexPath.row].quantity!)"
            if resData[indexPath.row].vorousType! == 1{
                cell.vegStausImg.image = #imageLiteral(resourceName: "Non_Veg")
            }else{
                cell.vegStausImg.image = #imageLiteral(resourceName: "Veg")
            }
            return cell
        }else if collectionView.tag == 222{
            let data = driverOrderData.order[1]
            let resData = driverOrderData.items.filter { (details) -> Bool in
                return data.restaurantId == details.restaurantId
            }
            cell.contentLbl.text = resData[indexPath.row].name!
            cell.itemsCountLbl.text = "✕\(resData[indexPath.row].quantity!)"
            if resData[indexPath.row].vorousType! == 1{
                cell.vegStausImg.image = #imageLiteral(resourceName: "Non_Veg")
            }else{
                cell.vegStausImg.image = #imageLiteral(resourceName: "Veg")
            }
            return cell
        }else{
            let resData = driverOrderData.items!
            cell.contentLbl.text = resData[indexPath.row].name!
            cell.itemsCountLbl.text = "✕\(resData[indexPath.row].quantity!)"
            if resData[indexPath.row].vorousType! == 0{
                cell.vegStausImg.image = #imageLiteral(resourceName: "Non_Veg")
            }else{
                cell.vegStausImg.image = #imageLiteral(resourceName: "Veg")
            }
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
    }
}
