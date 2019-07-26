//
//  Vendor.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 26/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit
import RealmSwift

class Vendor: RealmSwift.Object {
    
    @objc dynamic var id: Int = -1
    @objc dynamic var name: String = ""
    @objc dynamic var desc: String = ""
    
    convenience init(id: Int, name: String, desc: String) {
        self.init()
        
        self.id = id
        self.name = name
        self.desc = desc
    }

}
