//
//  RestaurantHeaderView.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 25/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit

class RestaurantHeaderView: NibView{

    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantAddressLabel: UILabel!
    @IBOutlet weak var restaurantIDLabel: UILabel!
    
    public func configure(restaurant: Restaurant) {
        restaurantNameLabel.text = restaurant.name
        restaurantAddressLabel.text = restaurant.address
        restaurantIDLabel.text = "Restaurant ID: \(restaurant.id)"
    }
    
}
