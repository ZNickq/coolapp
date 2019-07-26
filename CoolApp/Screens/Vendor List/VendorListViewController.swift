//
//  VendorListViewController.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 26/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit
import RealmSwift

class VendorListViewController: ColumnTableViewController {
    
    @IBOutlet weak var bigRestaurantView: RestaurantHeaderView!
    
    var vendors: Results<Vendor>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.columnedTableView.dataSource = self
        self.columnedTableView.register(UINib(nibName: "VendorTableViewCell", bundle: nil), forCellReuseIdentifier: "aCell")
        
        columnedTableView.layer.borderColor = UIColor.lightGray.cgColor
        columnedTableView.layer.borderWidth = 1.0
        
        restaurantUpdated()
        
    }
    
    func restaurantUpdated() {
        guard let restaurant = Restaurant.selectedRestaurant else {
            return
        }
        bigRestaurantView.configure(restaurant: restaurant)
        
        vendors = AppDelegate.shared.realm.objects(Vendor.self)
        columnedTableView.reloadData()
    }
    
    override func columnRatios() -> [SectionedItem] {
        
        let first = SectionedItem(ratio: 0.18, label: "ID")
        let second = SectionedItem(ratio: 0.35, label: "Vendor name")
        let third = SectionedItem(ratio: 0.35, label: "Product types")
        let fourth = SectionedItem(ratio: 0.1, label: "Order")
        
        return [first, second, third, fourth]
    }
    
    private var tappedVendor: Vendor?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showFilteredQuickOrder" else {
            return
        }
        guard let destVC = segue.destination as? QuickOrderViewController else {
            return
        }
        destVC.vendorFilter = tappedVendor
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
}

extension VendorListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vendors?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "aCell") as? VendorTableViewCell else {
            return UITableViewCell()
        }
        guard let vendor = vendors?[indexPath.row] else {
            return cell
        }
        
        cell.configure(vendor: vendor)
        cell.delegate = self
        
        return cell;
    }
    
}

extension VendorListViewController: VendorTableViewCellDelegate {
    
    
    func detailsTapped(cell: VendorTableViewCell) {
        guard let indexPath = columnedTableView.indexPath(for: cell) else {
            return
        }
        guard let tappedVendor = vendors?[indexPath.row] else {
            return
        }
        self.tappedVendor = tappedVendor
        
        self.performSegue(withIdentifier: "showFilteredQuickOrder", sender: self)
    }
    
}
