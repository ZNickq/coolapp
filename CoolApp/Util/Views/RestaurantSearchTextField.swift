//
//  RestaurantSearchTextField.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 24/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit
import SearchTextField

protocol RestaurantSearchDelegate: class{
    func didSelect(restaurant: Restaurant)
}

class RestaurantSearchTextField: SearchTextField {

    private var setupDone = false
    
    weak var restaurantDelegate: RestaurantSearchDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !setupDone {
            setupDone = true
            setupField()
        }
    }
    
    private func setupField() {
        typingStoppedDelay = 0.5
        
        theme.font = UIFont.systemFont(ofSize: 15)
        
        userStoppedTypingHandler = {
            if let criteria = self.text {
                if criteria.count > 0 {
                    self.showLoadingIndicator()
                    
                    self.searchMoreItemsInBackground(criteria) { results in
                        // Set new items to filter
                        self.filterItems(results)
                        
                        // Hide loading indicator
                        self.stopLoadingIndicator()
                    }
                }
            }
        }
        
        itemSelectionHandler = { results, selectedIndex in
            guard let selectedId = Int(results[selectedIndex].subtitle ?? "") else {
                return
            }
            guard let restaurant = AppDelegate.shared.realm.objects(Restaurant.self).filter("id == %@", selectedId).first else {
                return
            }
            self.text = restaurant.name
            self.restaurantDelegate?.didSelect(restaurant: restaurant)
        }
    }
    
    private func searchMoreItemsInBackground(_ criteria: String, completion: (([SearchTextFieldItem]) -> Void)) {
        
        let pp = AppDelegate.shared.realm.objects(Restaurant.self).filter { (each) -> Bool in
            "\(each.id)".localizedCaseInsensitiveContains(criteria) || each.name.localizedCaseInsensitiveContains(criteria)
        }
        
        completion(pp.map({ (each) -> SearchTextFieldItem in
            SearchTextFieldItem(title: each.name, subtitle: "\(each.id)")
        }))
    }

}
