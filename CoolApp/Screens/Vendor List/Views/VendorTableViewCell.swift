//
//  UndeliveredProductTableViewCell.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 25/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit

protocol VendorTableViewCellDelegate: class{
    
    func detailsTapped(cell: VendorTableViewCell)
    
}

class VendorTableViewCell: UITableViewCell {
    
    weak var delegate: VendorTableViewCellDelegate?
    
    @IBOutlet weak var vendorIDLabel: UILabel!
    @IBOutlet weak var vendorNameLabel: UILabel!
    @IBOutlet weak var vendorDescLabel: UILabel!
    
    func configure(vendor: Vendor) {
        vendorIDLabel.text = "\(vendor.id)"
        vendorNameLabel.text = "\(vendor.name)"
        vendorDescLabel.text = "\(vendor.desc)"
    }
    
    @IBAction func detailsTapped(_ sender: Any) {
        delegate?.detailsTapped(cell: self)
    }
}
