//
//  OrderHistoryViewController.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 25/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit
import RealmSwift

class OrderHistoryViewController: ColumnTableViewController {
    
    @IBOutlet weak var bigRestaurantView: RestaurantHeaderView!
    
    var orders: Results<Order>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.columnedTableView.dataSource = self
        self.columnedTableView.register(UINib(nibName: "OrderHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "aCell")
        
        columnedTableView.layer.borderColor = UIColor.lightGray.cgColor
        columnedTableView.layer.borderWidth = 1.0
        
        restaurantUpdated()
        
    }
    
    func restaurantUpdated() {
        guard let restaurant = Restaurant.selectedRestaurant else {
            return
        }
        bigRestaurantView.configure(restaurant: restaurant)
        
        orders = AppDelegate.shared.realm.objects(Order.self).sorted(byKeyPath: "date", ascending: false)
        columnedTableView.reloadData()
    }
    
    override func columnRatios() -> [SectionedItem] {
        
        let first = SectionedItem(ratio: 0.22, label: "Date")
        let second = SectionedItem(ratio: 0.4, label: "Order no.")
        let third = SectionedItem(ratio: 0.2, label: "Order value")
        let fourth = SectionedItem(ratio: 0.1, label: "Details")
        
        return [first, second, third, fourth]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    private var tappedOrder: Order?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard (segue.identifier ?? "") == "showOrderDetails" else {
            return
        }
        (segue.destination as? OrderDetailsViewController)?.selectedOrder = tappedOrder
    }
    
}

extension OrderHistoryViewController: OrderHistoryTableViewCellDelegate {
    
    func detailsTapped(cell: OrderHistoryTableViewCell) {
        guard let indexPath = columnedTableView.indexPath(for: cell) else {
            return
        }
        guard let tappedOrder = orders?[indexPath.row] else {
            return
        }
        self.tappedOrder = tappedOrder
        
        self.performSegue(withIdentifier: "showOrderDetails", sender: self)
    }
    
}

extension OrderHistoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "aCell") as? OrderHistoryTableViewCell else {
            return UITableViewCell()
        }
        guard let order = orders?[indexPath.row] else {
            return cell
        }
        
        cell.delegate = self
        cell.configure(order: order)
        
        return cell;
    }
    
    
}
