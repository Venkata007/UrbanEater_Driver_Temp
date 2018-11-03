//
//  OngoingTableViewCell.swift
//  DriverReadyToEat
//
//  Created by Nagaraju on 17/10/18.
//  Copyright © 2018 CasperonTechnologies. All rights reserved.
//

import UIKit

class OngoingTableViewCell: UITableViewCell {

    @IBOutlet weak var directionBtnWidthContraint: NSLayoutConstraint!
    @IBOutlet weak var pickupView: UIView!
    @IBOutlet weak var acceptView: UIView!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var rejectBtn: UIButton!
    @IBOutlet weak var pickupBtn: UIButton!
    @IBOutlet weak var restarantNameLbl: UILabel!
    @IBOutlet weak var acceptBtnViewHeightContarint: NSLayoutConstraint!
    @IBOutlet weak var bottomContraint: NSLayoutConstraint!
    @IBOutlet weak var topContraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        rejectBtn.layer.cornerRadius = 5.0
        acceptBtn.layer.cornerRadius = 5.0
        rejectBtn.layer.borderWidth = 1.0
        rejectBtn.layer.borderColor = #colorLiteral(red: 0, green: 0.7314415574, blue: 0.3181976676, alpha: 1)
        rejectBtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
