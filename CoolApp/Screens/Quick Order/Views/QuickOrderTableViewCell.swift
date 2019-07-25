//
//  QuickOrderTableViewCell.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 23/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit

protocol QuickOrderTableViewCellDelegate: class{
    
    func quantityUpdated(cell: QuickOrderTableViewCell, quantity: Int)
    
}

class QuickOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var orderAmountLabel: UILabel!
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var consumptionLabel: UILabel!
    @IBOutlet weak var onHandLabel: UILabel!
    @IBOutlet weak var suggestedOrderLabel: UILabel!
    
    @IBOutlet weak var reorderSwitch: UISwitch!
    @IBOutlet weak var orderStepper: UIStepper!
    
    weak var delegate: QuickOrderTableViewCellDelegate?
    
    func configure(product: Product, consumptionPeriod: FilterView.ConsumptionPeriod, currentQuantity: Int) {
        productNameLabel.text = product.name
        consumptionLabel.text = "\(product.consumptionHistory?.period(for: consumptionPeriod) ?? 0)"
        onHandLabel.text = "\(product.availableStock)"
        suggestedOrderLabel.text = "\(product.stockSuggestion)"
        
        
        orderStepper.value = Double(currentQuantity)
        orderAmountLabel.text = "\(currentQuantity)"
        
        updateSwitch(animated: false)
    }
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        orderAmountLabel.text = "\(Int(sender.value))"
        updateSwitch()
    }
    
    private func updateSwitch(animated: Bool = true) {
        reorderSwitch.setOn(orderStepper.value > 0, animated: animated)
        
        delegate?.quantityUpdated(cell: self, quantity: Int(orderStepper.value))
    }
    @IBAction func switchTapped(_ sender: UISwitch) {
        if (!sender.isOn) {
            orderStepper.value = 0.0
            stepperChanged(orderStepper)
        } else {
            if (orderStepper.value == 0.0) {
                orderStepper.value = 1.0
                stepperChanged(orderStepper)
            }
        }
    }
    
}
