//
//  Product.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 23/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit
import RealmSwift

class Product: RealmSwift.Object {
    
    @objc dynamic var id = -1
    @objc dynamic var name = ""
    
    @objc dynamic var consumptionHistory: ConsumptionHistory?
    @objc dynamic var category: ProductCategory?
    
    @objc dynamic var availableStock = 0
    @objc dynamic var stockSuggestion = 0
    
    @objc dynamic var price = 0.0
    
    @objc dynamic var vendor: Vendor? = nil
    
    convenience init(id: Int, name: String, category: ProductCategory, consumptionHistory: ConsumptionHistory? = nil, availableStock: Int, stockSuggestion: Int, price: Double, vendor: Vendor) {
        self.init()
        
        self.name = name
        self.id = id
        
        self.category = category
        self.consumptionHistory = consumptionHistory
        self.availableStock = availableStock
        self.stockSuggestion = stockSuggestion
        self.price = price
        
        self.vendor = vendor
    }

}

class ProductCategory: RealmSwift.Object {
    
    @objc dynamic var id = -1
    @objc dynamic var name = ""
    
    convenience init(id: Int, name: String) {
        self.init()
        
        self.id = id
        self.name = name
    }
    
}

class ConsumptionHistory: RealmSwift.Object {
    
    @objc dynamic var fourWeeks = 0
    @objc dynamic var sixWeeks = 0
    @objc dynamic var tenWeeks = 0
    @objc dynamic var twelveWeeks = 0
    
    func period(for period: FilterView.ConsumptionPeriod) -> Int {
        switch period {
        case .four:
            return fourWeeks
        case .six:
            return sixWeeks
        case .ten:
            return tenWeeks
        case .twelve:
            return twelveWeeks
        }
    }
    
    convenience init(four: Int, six: Int, ten: Int, twelve: Int) {
        self.init()
        
        self.fourWeeks = four
        self.sixWeeks = six
        self.tenWeeks = ten
        self.twelveWeeks = twelve
    }
    
    convenience init(random: Bool = false) {
        self.init()
        
        if (random) { // Only for demo purposes
            fourWeeks = Int.random(in: 1 ... 100)
            sixWeeks = Int.random(in: 1 ... 100)
            tenWeeks = Int.random(in: 1 ... 100)
            twelveWeeks = Int.random(in: 1 ... 100)
        }
    }
    
}
