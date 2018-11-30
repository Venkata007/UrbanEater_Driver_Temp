//
//  OrderInfoTableViewCell3.swift
//  DriverReadyToEat
//
//  Created by Nagaraju on 17/10/18.
//  Copyright © 2018 CasperonTechnologies. All rights reserved.
//

import UIKit

class OrderInfoTableViewCell3: UITableViewCell {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var OrdersCollectionView: UICollectionView!
    @IBOutlet weak var headerBtn: UIButton!
    @IBOutlet weak var arrowImg:UIImageView!
    @IBOutlet weak var deviderViewHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var dropDownImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        TheGlobalPoolManager.cornerAndBorder(headerView, cornerRadius: 5, borderWidth: 0, borderColor: .clear)
        self.OrdersCollectionView.register(UINib.init(nibName: "OrderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OrderCollectionViewCell")
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left:0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.OrdersCollectionView.frame.width, height: 30)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        OrdersCollectionView!.collectionViewLayout = layout
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
