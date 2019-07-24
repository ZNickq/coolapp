//
//  FilterTableViewCell.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 23/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var productTypeLabel: UILabel!
    @IBOutlet weak var productSwitch: UISwitch!
    
    var changedState: ((Bool) -> Void)?
    
    func configure(category: ProductCategory, switchState: Bool) {
        productTypeLabel.text = category.name
        productSwitch.isOn = switchState
    }
    
    @IBAction func onSwitchTapped(_ sender: UISwitch) {
        changedState?(sender.isOn)
    }
    
}
