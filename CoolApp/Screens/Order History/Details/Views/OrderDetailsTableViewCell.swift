//
//  OrderDetailsTableViewCell.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 25/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit

class OrderDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productUnitPriceLabel: UILabel!
    
    private static var numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.minimumFractionDigits = 2
        nf.maximumFractionDigits = 2
        
        return nf
    }()
    
    func configure(orderedProduct: OrderedProduct) {
        let product = orderedProduct
        
        productNameLabel.text = orderedProduct.product?.name ?? "N/A"
       
        
        let numberPrice = NSNumber(value: product.price)
        productPriceLabel.text = "$\(OrderDetailsTableViewCell.numberFormatter.string(from: numberPrice) ?? "N/A")"
        
        let numberUnitPrice = NSNumber(value: product.product?.price ?? 0)
        productUnitPriceLabel.text = "$\(OrderDetailsTableViewCell.numberFormatter.string(from: numberUnitPrice) ?? "N/A")"
    }
}
