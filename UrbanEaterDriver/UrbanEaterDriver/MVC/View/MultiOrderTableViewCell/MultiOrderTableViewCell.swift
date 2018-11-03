
//
//  MultiOrderTableViewCell.swift
//  DriverReadyToEat
//
//  Created by Nagaraju on 22/10/18.
//  Copyright © 2018 CasperonTechnologies. All rights reserved.
//

import UIKit

class MultiOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var navigationBtnWidthContaraint: NSLayoutConstraint!
    @IBOutlet weak var navigationBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
