//
//  OrderInfoTableViewCell1.swift
//  DriverReadyToEat
//
//  Created by Nagaraju on 17/10/18.
//  Copyright © 2018 CasperonTechnologies. All rights reserved.
//

import UIKit

class OrderInfoTableViewCell1: UITableViewCell {

    @IBOutlet weak var headerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        headerView.layer.cornerRadius = 5.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
