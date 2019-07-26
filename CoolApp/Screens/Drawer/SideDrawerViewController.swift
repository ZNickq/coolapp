//
//  SideDrawerViewController.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 25/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit

class SideDrawerViewController: UIViewController {

    @IBOutlet var menuButtons: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuButtons.forEach { $0.layer.cornerRadius = 8.0 }
    }

}
