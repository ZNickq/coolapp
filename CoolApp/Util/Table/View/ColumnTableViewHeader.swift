//
//  ColumnTableViewHeader.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 23/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit

class ColumnTableViewHeader: NibView {

    @IBOutlet weak var stackView: UIStackView!
    

    override func setupAppearance() {
        
    }
    
    func loadRatios(ratios: [SectionedItem]) {
        
        UIFont.familyNames.forEach({ familyName in
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            print(familyName, fontNames)
        })
        
        // Clear the table view of any remaining labels
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let stackViewWidthAnchor = stackView.widthAnchor
        
        var constraints: [NSLayoutConstraint] = []
        
        ratios.forEach { each in
            let sectionRatio = CGFloat(each.ratio)
            let sectionText = each.label
            
            let label = UILabel()
            label.textAlignment = .center
            label.backgroundColor = UIColor(rgb: 0x942645)
            label.textColor = UIColor.white
            label.font = UIFont(name: "UniversLTStd-Light", size: 22.0)
            label.text = sectionText
            
            stackView.addArrangedSubview(label)
            
            let constraint = label.widthAnchor.constraint(equalTo: stackViewWidthAnchor, multiplier: sectionRatio)
            constraints.append(constraint)
        }
        
        constraints.removeLast() // This allows the last view to take any remaining space
        constraints.forEach { $0.isActive = true }
        
        layoutIfNeeded()
        
    }
    
}

struct SectionedItem {
    var ratio: Float
    var label: String
}
