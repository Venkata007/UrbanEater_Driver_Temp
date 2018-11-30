//
//  OngoingTableViewCell.swift
//  UrbanEaterDriver
//
//  Created by Venkat@Hexadots on 27/11/18.
//  Copyright © 2018 Nagaraju. All rights reserved.
//

import UIKit

class OngoingTableViewCell: UITableViewCell {
    @IBOutlet weak var restaurantNameLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var callBtn: ButtonWithShadow!
    @IBOutlet weak var directionBtn: ButtonWithShadow!
    @IBOutlet weak var statusBtn: UIButton!
    @IBOutlet weak var statusBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var directionBtnWidth: NSLayoutConstraint!
    @IBOutlet weak var directionBtnHeight: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        TheGlobalPoolManager.cornerAndBorder(statusBtn, cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        self.collectionView.register(UINib.init(nibName: "OnGoingDishesCell", bundle: nil), forCellWithReuseIdentifier: "OnGoingDishesCell")
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left:0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.collectionView.frame.width, height: 25)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        collectionView!.collectionViewLayout = layout
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
