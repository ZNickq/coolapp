//
//  OptionPickerView.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 22/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit

class OptionPickerView: LoginSubview {

    @IBOutlet weak var newOrderView: UIView!
    @IBOutlet weak var dashboardView: UIView!
    
    override func setupAppearance() {
        newOrderView.layer.cornerRadius = 6.0
        dashboardView.layer.cornerRadius = 6.0
    }
    
    @IBAction func createNewOrder(_ sender: Any) {
        delegate?.nextTapped(option: .quickOrder)
    }
    
    @IBAction func dashboardTapped(_ sender: Any) {
        delegate?.nextTapped(option: .dashboards)
    }
    
    
}
