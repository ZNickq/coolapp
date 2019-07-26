//
//  UndeliveredProductTableViewCell.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 25/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit

protocol UndeliveredProductTableViewCellDelegate: class{
    func detailsTapped(cell: UndeliveredProductTableViewCell)
}

class UndeliveredProductTableViewCell: UITableViewCell {
    
    weak var delegate: UndeliveredProductTableViewCellDelegate?
    
    @IBOutlet private weak var productIDLabel: UILabel!
    @IBOutlet private weak var orderNumberLabel: UILabel!
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productPriceLabel: UILabel!
    
    func configure(orderedProduct: OrderedProduct) {
        let product = orderedProduct
        
        productIDLabel.text = "\(product.id)"
        orderNumberLabel.text = product.order?.code
        productNameLabel.text = product.product?.name ?? "N/A"
        
        let numberPrice = NSNumber(value: product.price)
        productPriceLabel.text = "$\(Formatters.currency.string(from: numberPrice) ?? "N/A")"
    }
    
    @IBAction func detailsTapped(_ sender: Any) {
        delegate?.detailsTapped(cell: self)
    }
}
