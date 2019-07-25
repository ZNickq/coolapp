//
//  Order.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 25/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit
import RealmSwift

class Order: RealmSwift.Object {
    
    @objc dynamic var id: Int = -1
    @objc dynamic var code: String = ""
    @objc dynamic var date: Date = Date()
    @objc dynamic var cachedPrice: Double = 0.0
    
    convenience init(id: Int, code: String, date: Date, cachedPrice: Double) {
        self.init()
        
        self.id = id
        self.code = code
        self.date = date
        self.cachedPrice = cachedPrice
    }
    
}

class OrderedProduct: RealmSwift.Object {
    
    @objc dynamic var id: Int = -1
    @objc dynamic var order: Order?
    @objc dynamic var product: Product?
    
    @objc dynamic var price: Double = 0.0
    @objc dynamic var delivered: Bool = false
    
    convenience init(id: Int, order: Order, product: Product, price: Double, delivered: Bool) {
        self.init()
        
        self.id = id
        self.order = order
        self.product = product
        self.price = price
        self.delivered = delivered
    }
    
}
