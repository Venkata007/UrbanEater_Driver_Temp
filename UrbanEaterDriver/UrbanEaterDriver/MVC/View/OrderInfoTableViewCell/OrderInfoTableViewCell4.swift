//
//  OrderInfoTableViewCell4.swift
//  DriverReadyToEat
//
//  Created by Nagaraju on 17/10/18.
//  Copyright © 2018 CasperonTechnologies. All rights reserved.
//

import UIKit

class OrderInfoTableViewCell4: UITableViewCell {

    @IBOutlet weak var subTotal: UILabel!
    @IBOutlet weak var restautarantOfferLbl: UILabel!
    @IBOutlet weak var deliveryFeeLbl: UILabel!
    @IBOutlet weak var packageLbl: UILabel!
    @IBOutlet weak var nightFeeLbl: UILabel!
    @IBOutlet weak var taxLbl: UILabel!
    @IBOutlet weak var yourEarningsLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
