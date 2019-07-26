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
    
    convenience init(id: Int, code: String, date: Date) {
        self.init()
        
        self.id = id
        self.code = code
        self.date = date
    }
    
    dynamic private var cachedPrice = RealmOptional<Double>()
    
    var price: Double {
        if let thePrice = cachedPrice.value {
            return thePrice
        }
        let calculatedPrice = AppDelegate.shared.realm.objects(OrderedProduct.self).filter("order == %@", self).reduce(0) {
            $0 + $1.price
        }
        try? AppDelegate.shared.realm.write {
            self.cachedPrice.value = calculatedPrice
        }
        return calculatedPrice
    }
    
}

class OrderedProduct: RealmSwift.Object {
    
    @objc dynamic var id: Int = -1
    @objc dynamic var order: Order?
    @objc dynamic var product: Product?
    @objc dynamic var quantity: Int = 0
    
    @objc dynamic var delivered: Bool = false
    
    var price: Double {
        return (product?.price ?? 0) * Double(quantity)
    }
    
    convenience init(id: Int, order: Order, product: Product, quantity: Int, delivered: Bool) {
        self.init()
        
        self.id = id
        self.order = order
        self.product = product
        self.quantity = quantity
        self.delivered = delivered
    }
    
}
