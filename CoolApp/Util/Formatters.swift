//
//  Formatters.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 26/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit

class Formatters {
    
    static let date: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    static let currency: NumberFormatter = {
        let nf = NumberFormatter()
        nf.minimumFractionDigits = 2
        nf.maximumFractionDigits = 2
        
        return nf
    }()

}
