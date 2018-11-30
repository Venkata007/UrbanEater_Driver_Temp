//
//  OrderCompletedDetailsView.swift
//  UrbanEaterDriver
//
//  Created by Venkat@Hexadots on 29/11/18.
//  Copyright © 2018 Nagaraju. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class OrderCompletedDetailsView: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "OngoingTableViewCell", bundle: nil), forCellReuseIdentifier: "OngoingTableViewCell")
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        ez.runThisInMainThread {
            TheGlobalPoolManager.cornerAndBorder(self.view, cornerRadius: 10, borderWidth: 0, borderColor: .clear)
        }
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
    }
}
extension OrderCompletedDetailsView : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "OngoingTableViewCell") as! OngoingTableViewCell
        cell.collectionView.tag = 07
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.statusBtnHeight.constant = 0
        cell.directionBtnWidth.constant = 0
        if indexPath.row == 0{
            cell.restaurantNameLbl.text = "Restaurant Name 01"
        }else if indexPath.row == 1{
            cell.restaurantNameLbl.text = "Restaurant Name 02"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
}
extension OrderCompletedDetailsView : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 07{
            return 3
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 07{
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
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
    }
}
