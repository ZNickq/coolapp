//
//  AppDelegate.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 22/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private(set) static var shared: AppDelegate!
    
    private(set) var realm: Realm!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        AppDelegate.shared = self
        
        setupMocking()
        
        return true
    }
    
    func setupMocking() {
        let resetMocking = true
        
        if (resetMocking) {
            try? FileManager.default.removeItem(at:Realm.Configuration.defaultConfiguration.fileURL!)
        }
        
        // Get the default Realm
        self.realm = try! Realm()
        
        let restaurants = realm.objects(Restaurant.self)
        
        guard restaurants.count == 0 else {
            return
        }
        
        // First, add some restaurants
        
        let res = Restaurant(name: "Restaurant Primaverii", id: 100, address: "Bucuresti, RO")
        let res2 = Restaurant(name: "Restaurant2 Iancu Green", id: 102, address: "Iasi, RO")
        let res3 = Restaurant(name: "Restaurant3 Expozitiei", id: 103, address: "London, UK")
        
        
        // Now, some product categories
        var categoryId = 99
        let allCategories: [ProductCategory] = ["Food", "Drinks", "Disposables", "Kitchen Equipment", "Cleaning supplies", "Clothing", "Others"].map { (each) -> ProductCategory in
            categoryId = categoryId + 1
            return ProductCategory(id: categoryId, name: each)
        }
        
        // And some vendors
        var vendorId = 99
        let allVendors: [Vendor] = [("Mega Image", "Fruits, Vegetables"), ("Vendor 2", "Clothing | Cleaning supplies"), ("Carrefour", "Accomodation"), ("Some other Vendor", "Sweets"), ("Another one", "Silverwear")].map { (each) -> Vendor in
            vendorId = vendorId + 1
            return Vendor(id: vendorId, name: each.0, desc: each.1)
        }
        
        //Some Products
        
        var productId = 100
        let allProducts = ["Pizza", "Coke", "Tiramisu", "Toilet paper", "Fryer pan", "Tomato sauce", "Napkin", "Fork", "Shirt", "Pants", "Paper Menu", "Non-smoking signs"].map { productName -> Product in
            
            let category = allCategories.randomElement()!
            let vendor = allVendors.randomElement()!
            let price = Double(Int.random(in: 10..<200))
            let stock = Int.random(in: 10..<100)
            let stockSuggestion = Int.random(in: 10..<100)
            let history = ConsumptionHistory(random: true)
            
            productId += 1
            
            return Product(id: productId, name: productName, category: category, consumptionHistory: history, availableStock: stock, stockSuggestion: stockSuggestion, price: price,vendor: vendor)
        }
        
        // And some Orders
        
        let todayDate = Date()
        let orders = (500..<515).map { each -> Order in
            let id = each
            let code = String.randomHash(12)
            
            let daysToSubtract = -1 * Int.random(in: 0 ..< 16)
            let date = Calendar.current.date(byAdding: .day, value: daysToSubtract, to: todayDate) ?? Date()
            
            return Order(id: id, code: code, date: date)
        }
        
        let orderedProducts = (400..<440).map { each -> OrderedProduct in
            let id = each
            let order = orders.randomElement()!
            let product = allProducts.randomElement()!
            let quant = Double.random(in: 1.0 ..< 10.0)
            let delivered = Bool.random()
            return OrderedProduct(id: id, order: order, product: product, quantity: Int(quant), delivered: delivered)
        }
        
        
        
        try? realm.write {
            realm.add(res)
            realm.add(res2)
            realm.add(res3)
            
            allProducts.forEach {
                realm.add($0)
            }
            orderedProducts.forEach {
                realm.add($0)
            }
        }
    }

}
