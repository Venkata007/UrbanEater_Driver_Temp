//
//  HelpSupportViewController.swift
//  DriverReadyToEat
//
//  Created by Nagaraju on 16/10/18.
//  Copyright © 2018 CasperonTechnologies. All rights reserved.
//

import UIKit
 //
class HelpSupportViewController: UIViewController {

    var listMenu = [String]()
    
    @IBOutlet weak var helpTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        listMenu = ["Contact Us","Feedback","FAQ","Privacy Policy","Terms of Use"]
    }
    //MARK:- IB Action Outlets
    @IBAction func backBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension HelpSupportViewController : UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return listMenu.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell : HelpSupportTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellHelpSupport") as! HelpSupportTableViewCell
        cell.titleLbl.text = listMenu[indexPath.row] as String
        return cell;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
