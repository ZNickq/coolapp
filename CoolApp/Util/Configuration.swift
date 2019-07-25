//
//  Configuration.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 25/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit

class Configuration {
    
    static let shared = Configuration()
    
    private init() {}
    
    var selectedRestaurantId: Int {
        get {
            return UserDefaults.standard.integer(forKey: "selectedRestaurantId")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "selectedRestaurantId")
        }
    }
    
    
}

