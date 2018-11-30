//
//  OrderCompletedCell.swift
//  UrbanEaterDriver
//
//  Created by Venkat@Hexadots on 29/11/18.
//  Copyright © 2018 Nagaraju. All rights reserved.
//

import UIKit

class OrderCompletedCell: UITableViewCell {

    @IBOutlet weak var orderIDLbl: UILabelPadded!
    @IBOutlet weak var amountLbl: UILabelPadded!
    @IBOutlet weak var restaurantName: UILabelPadded!
    @IBOutlet weak var statusLbl: UILabelPadded!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
