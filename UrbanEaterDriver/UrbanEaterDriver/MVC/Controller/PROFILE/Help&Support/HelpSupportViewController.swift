//
//  HelpSupportViewController.swift
//  DriverReadyToEat
//
//  Created by Nagaraju on 16/10/18.
//  Copyright © 2018 CasperonTechnologies. All rights reserved.
//

import UIKit
 //
class HelpSupportViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var listMenu = [String]()
    
    @IBOutlet weak var helpTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        listMenu = ["Contact Us","Feedback","FAQ","Privacy Policy","Terms of Use"]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return listMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : HelpSupportTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellHelpSupport") as! HelpSupportTableViewCell
        cell.titleLbl.text = listMenu[indexPath.row] as String
        //cell.preservesSuperviewLayoutMargins = false
        //cell.separatorInset = UIEdgeInsets.zero
        //cell.layoutMargins = UIEdgeInsets.zero
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 40
        
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
