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
            try! FileManager.default.removeItem(at:Realm.Configuration.defaultConfiguration.fileURL!)
        }
        
        // Get the default Realm
        self.realm = try! Realm()
        
        let restaurants = realm.objects(Restaurant.self)
        
        
        if (restaurants.count == 0) {
            
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
            
            // Now some products with randomly generated consumption histories
            var allProducts: [Product] = []
            allProducts.append(Product(id: 100, name: "Pizza", category: allCategories[0], consumptionHistory: ConsumptionHistory(random: true), availableStock: 50, stockSuggestion: 30, price: 10))
            allProducts.append(Product(id: 101, name: "Coke", category: allCategories[1], consumptionHistory: ConsumptionHistory(random: true), availableStock: 34, stockSuggestion: 48, price: 20))
            allProducts.append(Product(id: 102, name: "Tiramisu", category: allCategories[0], consumptionHistory: ConsumptionHistory(random: true), availableStock: 213, stockSuggestion: 74, price: 15))
            allProducts.append(Product(id: 103, name: "Toilet paper", category: allCategories[2], consumptionHistory: ConsumptionHistory(random: true), availableStock: 54, stockSuggestion: 88, price: 17))
            allProducts.append(Product(id: 104, name: "Fryer pan", category: allCategories[3], consumptionHistory: ConsumptionHistory(random: true), availableStock: 72, stockSuggestion: 57, price: 23))
            allProducts.append(Product(id: 105, name: "Tomato sauce", category: allCategories[1], consumptionHistory: ConsumptionHistory(random: true), availableStock: 80, stockSuggestion: 100, price: 30))
            allProducts.append(Product(id: 106, name: "Napkin", category: allCategories[2], consumptionHistory: ConsumptionHistory(random: true), availableStock: 15, stockSuggestion: 231, price: 28))
            allProducts.append(Product(id: 107, name: "Fork", category: allCategories[2], consumptionHistory: ConsumptionHistory(random: true), availableStock: 86, stockSuggestion: 123, price: 25))
            allProducts.append(Product(id: 108, name: "Shirt", category: allCategories[5], consumptionHistory: ConsumptionHistory(random: true), availableStock: 34, stockSuggestion: 88, price: 24))
            allProducts.append(Product(id: 108, name: "Pants", category: allCategories[5], consumptionHistory: ConsumptionHistory(random: true), availableStock: 76, stockSuggestion: 90, price: 21))
            allProducts.append(Product(id: 109, name: "Paper Menu", category: allCategories[6], consumptionHistory: ConsumptionHistory(random: true), availableStock: 30, stockSuggestion: 45, price: 60))
            allProducts.append(Product(id: 110, name: "Non-smoking signs", category: allCategories[6], consumptionHistory: ConsumptionHistory(random: true), availableStock: 65, stockSuggestion: 42, price: 50))
            
            
            // And some Orders
            
            let orders = (500..<515).map { each -> Order in
                let id = each
                let code = randomHash(12)
                let date = Date()
                let cachedPrice = Double.random(in: 10.0 ..< 200.0)
                return Order(id: id, code: code, date: date, cachedPrice: cachedPrice)
            }
            
            let orderedProducts = (400..<440).map { each -> OrderedProduct in
                let id = each
                let order = orders.randomElement()!
                let product = allProducts.randomElement()!
                let price = Double.random(in: 10.0 ..< 100.0)
                let delivered = Bool.random()
                return OrderedProduct(id: id, order: order, product: product, price: price, delivered: delivered)
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
    
    private func randomHash(_ length: Int) -> String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }

}
