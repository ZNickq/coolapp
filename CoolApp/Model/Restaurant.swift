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
    
    @objc dynamic var id: Int = -1
    @objc dynamic var name: String = ""
    
//    init(id: Int, name: String) {
//        self.name = name;
//        self.id = id;
//    }
//
    convenience init(name: String, id: Int) {
        self.init()
        
        self.name = name
        self.id = id
    }
    

}
