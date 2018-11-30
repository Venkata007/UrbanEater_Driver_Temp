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
    }
    //MARK:- IB Action Outlets
    @IBAction func backBtn(_ sender: UIButton) {
        ez.topMostVC?.popVC()
    }
}
extension OrderDetailsViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if indexPath.row == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderInfoCell4") as! OrderInfoTableViewCell4
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "OngoingTableViewCell") as! OngoingTableViewCell
        cell.collectionView.tag = 0
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.callBtn.isHidden = true
        cell.directionBtn.isHidden = true
        if indexPath.row == 0{
        }else if indexPath.row == 1{
            cell.restaurantNameLbl.text = "Restaurant Name 02"
        }else if indexPath.row == 2{
            cell.restaurantNameLbl.text = "Delivery Location"
        }
        cell.statusBtn.setTitle("Completed", for: .normal)
        cell.statusBtn.backgroundColor = .greenColor
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3{
            return 220
        }
        return 275
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "OngoingHeaderCell") as! OngoingHeaderCell
        return headerCell.contentView
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
extension OrderDetailsViewController : UICollectionViewDataSource,UICollectionViewDelegate{
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
