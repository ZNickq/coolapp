//
//  OrderHistoryTableViewCell.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 25/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit

protocol OrderHistoryTableViewCellDelegate: class{
    func detailsTapped(cell: OrderHistoryTableViewCell)
}

class OrderHistoryTableViewCell: UITableViewCell {
    
    weak var delegate: OrderHistoryTableViewCellDelegate?
    
    @IBOutlet private weak var orderDateLabel: UILabel!
    @IBOutlet private weak var orderNumberLabel: UILabel!
    @IBOutlet private weak var orderPriceLabel: UILabel!
    
    func configure(order: Order) {
        orderDateLabel.text = Formatters.date.string(from: order.date)
        orderNumberLabel.text = order.code
        
        orderPriceLabel.text = "$\(Formatters.currency.string(from: NSNumber(value: order.price)) ?? "N/A")"
    }
    
    @IBAction func detailsTapped(_ sender: Any) {
        delegate?.detailsTapped(cell: self)
    }
}
