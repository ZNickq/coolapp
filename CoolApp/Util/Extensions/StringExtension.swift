//
//  StringExtension.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 26/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit

extension String {
    
    public static func randomHash(_ length: Int = 12) -> String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
}
