//
//  EditProfileVC.swift
//  UrbanEaterDriver
//
//  Created by Venkat@Hexadots on 30/11/18.
//  Copyright © 2018 Nagaraju. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class EditProfileVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let itemsHeaderArray = ["Name *","MobileNumber *","Email *","City *","Vehicle Type *","Driving Licence *"]
    let itemsArray = ["Vamsi","+91 9533565007","vamsi007@gmail.com","Hydrebad","Two weeler - Hero Glamour","TN75 2013 0007700"]
    
    @IBOutlet weak var submitBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
    }
    //MARK:- IB Action Outlets
    @IBAction func backBtn(_ sender: UIButton) {
        ez.topMostVC?.popVC()
    }
    @IBAction func submitBtn(_ sender: UIButton) {
    }
}
//MARK:- UI Table View Cell Class
class ItemsCell : UITableViewCell{
    @IBOutlet weak var itemTF: UITextField!
    @IBOutlet weak var headerLbl: UILabel!
}
// MARK:- UI Table View Delegates and Data Sources
extension EditProfileVC  : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return itemsHeaderArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell : ItemsCell = tableView.dequeueReusableCell(withIdentifier: "ItemsCell") as! ItemsCell
        cell.headerLbl.text = itemsHeaderArray[indexPath.row]
        cell.itemTF.attributedPlaceholder = NSAttributedString(string: "Enter \(itemsHeaderArray[indexPath.row].replacingOccurrences(of: " *", with: ""))", attributes: [NSAttributedStringKey.foregroundColor : UIColor.lightGray])
        cell.itemTF.text = itemsArray[indexPath.row]
        cell.itemTF.setBottomBorder()
        tableView.separatorStyle = .none
        return  cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
