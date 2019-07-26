//
//  OrderDetailsTableViewCell.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 25/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit

class OrderDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productPriceLabel: UILabel!
    @IBOutlet private weak var productUnitPriceLabel: UILabel!
    
    func configure(orderedProduct: OrderedProduct) {
        let product = orderedProduct
        let numberPrice = NSNumber(value: product.price)
        let numberUnitPrice = NSNumber(value: product.product?.price ?? 0)
        
        productNameLabel.text = orderedProduct.product?.name ?? "N/A"
        productPriceLabel.text = "$\(Formatters.currency.string(from: numberPrice) ?? "N/A")"
        productUnitPriceLabel.text = "$\(Formatters.currency.string(from: numberUnitPrice) ?? "N/A")"
    }
}
