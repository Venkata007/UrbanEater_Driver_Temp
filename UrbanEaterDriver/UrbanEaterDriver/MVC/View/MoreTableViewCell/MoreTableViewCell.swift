//
//  MoreTableViewCell.swift
//  DriverReadyToEat
//
//  Created by Casperon iOS on 24/11/17.
//  Copyright © 2017 CasperonTechnologies. All rights reserved.
//

import UIKit

class MoreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageMenu: UIImageView!
    
    @IBOutlet weak var titleMenu: UILabel!
    
    @IBOutlet weak var languagetitle_lbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
