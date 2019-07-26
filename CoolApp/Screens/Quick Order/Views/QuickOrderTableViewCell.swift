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

    @IBOutlet private weak var stackView: UIStackView!

    @IBOutlet private weak var orderAmountLabel: UILabel!
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var consumptionLabel: UILabel!
    @IBOutlet private weak var onHandLabel: UILabel!
    @IBOutlet private weak var suggestedOrderLabel: UILabel!
    
    @IBOutlet private weak var reorderSwitch: UISwitch!
    @IBOutlet private weak var orderStepper: UIStepper!
    
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
    
    @IBAction private func stepperChanged(_ sender: UIStepper) {
        orderAmountLabel.text = "\(Int(sender.value))"
        updateSwitch()
    }
    @IBAction private func switchTapped(_ sender: UISwitch) {
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
    
    private func updateSwitch(animated: Bool = true) {
        reorderSwitch.setOn(orderStepper.value > 0, animated: animated)
        
        delegate?.quantityUpdated(cell: self, quantity: Int(orderStepper.value))
    }
    
}
