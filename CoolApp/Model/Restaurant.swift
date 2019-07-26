//
//  Restaurant.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 22/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit
import RealmSwift

class Restaurant: RealmSwift.Object {
    
    static var selectedRestaurant: Restaurant? {
        let restaurantID = Configuration.shared.selectedRestaurantId
        return AppDelegate.shared.realm.objects(Restaurant.self).filter("id == %@", restaurantID).first
    }
    
    @objc dynamic var id: Int = -1
    @objc dynamic var name: String = ""
    @objc dynamic var address: String = ""
    
    convenience init(name: String, id: Int, address: String) {
        self.init()
        
        self.name = name
        self.id = id
        self.address = address
    }
    

}
