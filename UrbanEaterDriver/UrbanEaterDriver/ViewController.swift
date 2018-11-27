//
//  ViewController.swift
//  UrbanEaterDriver
//
//  Created by Nagaraju on 01/11/18.
//  Copyright © 2018 Nagaraju. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var swipeView: UIView!
    @IBOutlet weak var backView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.backView.isHidden = true
        self.swipeView.isHidden = true
    }
    
    
}
