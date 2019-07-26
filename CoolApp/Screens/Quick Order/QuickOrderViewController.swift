//
//  QuickOrderViewController.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 23/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit
import RealmSwift
import SideMenu

class QuickOrderViewController: ColumnTableViewController {

    @IBOutlet weak var bigRestaurantView: RestaurantHeaderView!
    
    var vendorFilter: Vendor? = nil // Only used when being accessed from the vendor list
    
    var products: Results<Product>? = nil
    var quantities: [Int: Int] = [:]
    
    var consumptionPeriod = FilterView.ConsumptionPeriod.four
    
    @IBOutlet weak var filterView: FilterView!
    @IBOutlet weak var filterHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var restaurantSearchTextField: RestaurantSearchTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let vendorFilter = vendorFilter {
            self.title = "\(vendorFilter.name)"
            self.navigationItem.leftBarButtonItem = nil
            self.navigationItem.rightBarButtonItems = nil
        }
        
        filterView.delegate = self
        
        self.columnedTableView.dataSource = self
        self.columnedTableView.register(UINib(nibName: "QuickOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "aCell")
        
        columnedTableView.layer.borderColor = UIColor.lightGray.cgColor
        columnedTableView.layer.borderWidth = 1.0
        
        restaurantSearchTextField.restaurantDelegate = self
        restaurantUpdated()
        
    }
    
    func restaurantUpdated() {
        guard let restaurant = Restaurant.selectedRestaurant else {
            return
        }
        bigRestaurantView.configure(restaurant: restaurant)
        
        products = queryProducts()
        columnedTableView.reloadData()
    }
    
    override func columnRatios() -> [SectionedItem] {
        
        let first = SectionedItem(ratio: 0.2, label: "Products")
        let second = SectionedItem(ratio: 0.15, label: "Consumption")
        let third = SectionedItem(ratio: 0.15, label: "On Hand")
        let fourth = SectionedItem(ratio: 0.2, label: "Suggested order")
        let fifth = SectionedItem(ratio: 0.1, label: "Re-order")
        let sixth = SectionedItem(ratio: 0.1, label: "Re-order QTY")
        
        return [first, second, third, fourth, fifth, sixth]
    }
    
    @IBAction func filterTapped(_ sender: Any) {
        if (filterHeightConstraint.constant < 1) {
            UIView.animate(withDuration: 0.2) {
                self.filterHeightConstraint.constant = 340
                self.view.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.filterHeightConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func placeOrderTapped(_ sender: Any) {
        let maxOrderId: Int? = AppDelegate.shared.realm.objects(Order.self).max(ofProperty: "id")
        let maxOrderedProductId: Int? = AppDelegate.shared.realm.objects(OrderedProduct.self).max(ofProperty: "id")
        guard let newId = maxOrderId else {
            return
        }
        let order = Order(id: newId + 1, code: String.randomHash(), date: Date())
        let productQuants: [Int: Int] = quantities.filter { $0.value > 0 }
        
        guard !productQuants.isEmpty else {
            self.showAlert(alertText: "Alert", alertMessage: "You can't send an empty order!")
            return
        }
        
        guard var currentOrderedProductId = maxOrderedProductId else {
            return
        }
        
        let orderedProducts = productQuants.compactMap { (key, value) -> OrderedProduct? in
            currentOrderedProductId += 1
            guard let product = AppDelegate.shared.realm.objects(Product.self).filter("id == %@", key).first else {
                return nil
            }
            return OrderedProduct(id: currentOrderedProductId, order: order, product: product, quantity: value, delivered: false)
        }
        
        do {
            try AppDelegate.shared.realm.write {
                AppDelegate.shared.realm.add(orderedProducts)
            }
            self.showAlert(alertText: "Alert", alertMessage: "Order sent successfully!")
            self.resetQuantities()
        } catch {
            self.showAlert(alertText: "Alert", alertMessage: "Order could not be saved!")
        }
        
    }
    
    func resetQuantities() {
        quantities = [:]
        columnedTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func quantity(for product: Product) -> Int {
        if let q = quantities[product.id] {
            return q
        }
        quantities[product.id] = 0
        return 0
    }
    
    private func queryProducts() -> Results<Product> {
        var results = AppDelegate.shared.realm.objects(Product.self)
        if let vendor = vendorFilter {
            results = results.filter("vendor == %@", vendor)
        }
        return results
    }

}

extension QuickOrderViewController: RestaurantSearchDelegate {
    
    func didSelect(restaurant: Restaurant) {
        Configuration.shared.selectedRestaurantId = restaurant.id
        restaurantUpdated()
        
        self.searchTapped(self)
    }
}

// Methods for handling search / restaurant change
extension QuickOrderViewController {
    
    @IBAction func searchTapped(_ sender: Any) {
        guard let field = restaurantSearchTextField else {
            return
        }
        
        field.isHidden = !field.isHidden
        field.text = ""
        
        if !field.isHidden {
            restaurantSearchTextField.becomeFirstResponder()
        } else {
            restaurantSearchTextField.resignFirstResponder()
        }
    }
    
}

extension QuickOrderViewController: FilterViewDelegate {
    
    func filterViewConsumptionPeriodChanged(period: FilterView.ConsumptionPeriod) {
        self.consumptionPeriod = period
        
        columnedTableView.reloadData()
    }
    
    func filterViewSwitchesChanged(newStates: [Int : Bool]) {
        let validProducts = Array(newStates.filter { $1 }.keys)
        products = queryProducts().filter("category.id IN %@", validProducts)
        
        columnedTableView.reloadData()
    }
    
    
}

extension QuickOrderViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "aCell") as? QuickOrderTableViewCell else {
            return UITableViewCell()
        }
        guard let product = products?[indexPath.row] else {
            return cell
        }
        
        cell.configure(product: product, consumptionPeriod: consumptionPeriod, currentQuantity: quantity(for: product))
        cell.delegate = self
        
        return cell;
    }
    
    
}

extension QuickOrderViewController: QuickOrderTableViewCellDelegate {
    
    func quantityUpdated(cell: QuickOrderTableViewCell, quantity: Int) {
        guard let indexPath = columnedTableView.indexPath(for: cell) else {
            return
        }
        guard let product = products?[indexPath.row] else {
            return
        }
        
        quantities[product.id] = quantity
    }
    
}
