//
//  UndeliveredProductsViewController.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 25/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit
import RealmSwift

class UndeliveredProductsViewController: ColumnTableViewController {
    
    @IBOutlet weak var bigRestaurantView: RestaurantHeaderView!
    
    var products: Results<OrderedProduct>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.columnedTableView.dataSource = self
        self.columnedTableView.register(UINib(nibName: "UndeliveredProductTableViewCell", bundle: nil), forCellReuseIdentifier: "aCell")
        
        columnedTableView.layer.borderColor = UIColor.lightGray.cgColor
        columnedTableView.layer.borderWidth = 1.0
        
        restaurantUpdated()
        
    }
    
    func restaurantUpdated() {
        guard let restaurant = Restaurant.selectedRestaurant else {
            return
        }
        bigRestaurantView.configure(restaurant: restaurant)
        
        products = AppDelegate.shared.realm.objects(OrderedProduct.self).filter("delivered == NO")
        columnedTableView.reloadData()
    }
    
    override func columnRatios() -> [SectionedItem] {
        
        let first = SectionedItem(ratio: 0.13, label: "ID")
        let second = SectionedItem(ratio: 0.22, label: "Order no.")
        let third = SectionedItem(ratio: 0.37, label: "Product name")
        let fourth = SectionedItem(ratio: 0.13, label: "Price")
        let fifth = SectionedItem(ratio: 0.1, label: "Details")
        
        return [first, second, third, fourth, fifth]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
}

extension UndeliveredProductsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "aCell") as? UndeliveredProductTableViewCell else {
            return UITableViewCell()
        }
        guard let product = products?[indexPath.row] else {
            return cell
        }
        
        cell.configure(orderedProduct: product)

        return cell;
    }
    
    
}
