//
//  OngoingHeaderCell.swift
//  UrbanEaterDriver
//
//  Created by Venkat@Hexadots on 29/11/18.
//  Copyright © 2018 Nagaraju. All rights reserved.
//

import UIKit

class OngoingHeaderCell: UITableViewCell {

    @IBOutlet weak var orderID: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
