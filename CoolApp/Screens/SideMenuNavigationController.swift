//
//  SideMenuNavigationController.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 24/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit
import SideMenu

class SideMenuNavigationController: UISideMenuNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenuManager.menuFadeStatusBar = false
    }
    
}
