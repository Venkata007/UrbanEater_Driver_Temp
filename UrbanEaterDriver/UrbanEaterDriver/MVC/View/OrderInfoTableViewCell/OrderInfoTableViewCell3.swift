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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        headerView.layer.cornerRadius = 2.0
        headerView.layer.borderWidth = 1.0
        headerView.layer.borderColor = #colorLiteral(red: 0.8723144531, green: 0.8723144531, blue: 0.8723144531, alpha: 1)
        headerView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
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
