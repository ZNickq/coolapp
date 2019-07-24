//
//  QuickOrderViewController.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 23/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit
import RealmSwift

class QuickOrderViewController: ColumnTableViewController {

    @IBOutlet weak var bigRestaurantView: UIView!
    
    var products: [Product] = []
    var quantities: [Product: Int] = [:]
    
    var consumptionPeriod = FilterView.ConsumptionPeriod.four
    
    @IBOutlet weak var filterView: FilterView!
    @IBOutlet weak var filterHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        products = AppDelegate.shared.realm.objects(Product.self).map { $0 }
        filterView.delegate = self
        
        bigRestaurantView.beautify()
        
        self.columnedTableView.dataSource = self
        self.columnedTableView.register(UINib(nibName: "QuickOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "aCell")
        
        columnedTableView.layer.borderColor = UIColor.lightGray.cgColor
        columnedTableView.layer.borderWidth = 1.0
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func quantity(for product: Product) -> Int {
        if let q = quantities[product] {
            return q
        }
        quantities[product] = 0
        return 0
    }

}

extension QuickOrderViewController: FilterViewDelegate {
    
    func filterViewConsumptionPeriodChanged(period: FilterView.ConsumptionPeriod) {
        self.consumptionPeriod = period
        
        columnedTableView.reloadData()
    }
    
    func filterViewSwitchesChanged(newStates: [Int : Bool]) {
        products = AppDelegate.shared.realm.objects(Product.self).filter { newStates[$0.category?.id ?? -1] ?? false == true }
        
        columnedTableView.reloadData()
    }
    
    
}

extension QuickOrderViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "aCell") as? QuickOrderTableViewCell else {
            return UITableViewCell()
        }
        let product = products[indexPath.row]
        
        cell.configure(product: products[indexPath.row], consumptionPeriod: consumptionPeriod, currentQuantity: quantity(for: product))
        cell.delegate = self
        
        return cell;
    }
    
    
}

extension QuickOrderViewController: QuickOrderTableViewCellDelegate {
    
    func quantityUpdated(cell: QuickOrderTableViewCell, quantity: Int) {
        guard let indexPath = columnedTableView.indexPath(for: cell) else {
            return
        }
        let product = products[indexPath.row]
        
        quantities[product] = quantity
    }
    
}
