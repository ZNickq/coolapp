//
//  OrderHistoryViewController.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 25/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit
import RealmSwift

class OrderDetailsViewController: ColumnTableViewController {
    
    @IBOutlet weak var bigRestaurantView: RestaurantHeaderView!
    @IBOutlet weak var totalPriceButton: UIButton!
    
    var selectedOrder: Order?
    var products: Results<OrderedProduct>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.columnedTableView.dataSource = self
        self.columnedTableView.register(UINib(nibName: "OrderDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "aCell")
        
        columnedTableView.layer.borderColor = UIColor.lightGray.cgColor
        columnedTableView.layer.borderWidth = 1.0
        
        restaurantUpdated()
    }
    
    func restaurantUpdated() {
        guard let restaurant = Restaurant.selectedRestaurant else {
            return
        }
        bigRestaurantView.configure(restaurant: restaurant)
        
        if let order = selectedOrder {
            
            self.title = "Order Number \(order.code)"
            
            products = AppDelegate.shared.realm.objects(OrderedProduct.self).filter("order == %@", order)
            totalPriceButton.setTitle("Total: $\(order.price)", for: .normal)
        }
        columnedTableView.reloadData()
    }
    
    override func columnRatios() -> [SectionedItem] {
        
        let first = SectionedItem(ratio: 0.7, label: "Product name")
        let second = SectionedItem(ratio: 0.13, label: "Unit Price")
        let third = SectionedItem(ratio: 0.1, label: "Total Price")
        
        return [first, second, third]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
}

extension OrderDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "aCell") as? OrderDetailsTableViewCell else {
            return UITableViewCell()
        }
        guard let order = products?[indexPath.row] else {
            return cell
        }
        
        cell.configure(orderedProduct: order)
        
        return cell;
    }
    
    
}
