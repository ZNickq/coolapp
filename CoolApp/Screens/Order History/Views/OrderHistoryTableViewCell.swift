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
    
    private static var numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.minimumFractionDigits = 2
        nf.maximumFractionDigits = 2
        
        return nf
    }()
    
    private static var dateFormatter: DateFormatter = {
        let nf = DateFormatter()
        nf.dateFormat = "d MMMM yyyy"
        return nf
    }()
    
    func configure(order: Order) {
    
        orderDateLabel.text = OrderHistoryTableViewCell.dateFormatter.string(from: order.date)
        orderNumberLabel.text = order.code
        
        let numberPrice = NSNumber(value: order.price)
        orderPriceLabel.text = "$\(OrderHistoryTableViewCell.numberFormatter.string(from: numberPrice) ?? "N/A")"
    }
    
    @IBAction func detailsTapped(_ sender: Any) {
        delegate?.detailsTapped(cell: self)
    }
}
