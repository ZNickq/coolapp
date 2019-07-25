//
//  FilterView.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 23/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit
import RealmSwift

protocol FilterViewDelegate: class{
    
    func filterViewConsumptionPeriodChanged(period: FilterView.ConsumptionPeriod)
    func filterViewSwitchesChanged(newStates: [Int: Bool])
    
}

class FilterView: NibView {
    
    enum ConsumptionPeriod: Int {
        case four = 0, six, ten, twelve
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: FilterViewDelegate?
    
    private var productTypes: Results<ProductCategory>?
    
    private var filterState: [Int: Bool] = [:]
    
    override func setupAppearance() {
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "FilterTableViewCell", bundle: nil), forCellReuseIdentifier: "aCell")

        productTypes = AppDelegate.shared.realm.objects(ProductCategory.self)
        
        productTypes?.forEach({ (each) in
            filterState[each.id] = true
        })
        
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.0
        
    }
    
    @IBAction func consumptionPeriodChanged(_ sender: UISegmentedControl) {
        guard let newSelection = ConsumptionPeriod(rawValue: sender.selectedSegmentIndex) else {
            return
        }
        delegate?.filterViewConsumptionPeriodChanged(period: newSelection)
    }
    
    private var showAllProducts: Bool {
        get {
            return filterState.filter { !$0.value }.count == 0
        }
        set {
            filterState.keys.forEach { filterState[$0] = newValue }
        }
    }
    
    private func switchesUpdated() {
        tableView.visibleCells.compactMap { $0 as? FilterTableViewCell }.forEach { (each) in
            guard let indexPath = tableView.indexPath(for: each) else { return }
            
            each.productSwitch.setOn(stateForSwitch(indexPath: indexPath), animated: true)
        }
        
        delegate?.filterViewSwitchesChanged(newStates: filterState)
    }
    
    private func stateForSwitch(indexPath: IndexPath) -> Bool {
        if (indexPath.row == 0) {
            return showAllProducts
        } else {
            guard let productType = productTypes?[indexPath.row - 1] else {
                return false
            }
            return filterState[productType.id] ?? true
        }
    }

}

extension FilterView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (productTypes?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "aCell") as? FilterTableViewCell else {
            return UITableViewCell()
        }
        guard indexPath.row > 0 else {
            cell.configure(category: ProductCategory(id: 0, name: "All Products"), switchState: stateForSwitch(indexPath: indexPath))
            cell.changedState = { [weak self] newState in
                self?.showAllProducts = newState
                self?.switchesUpdated()
                
            }
            return cell
        }
        
        guard let productType = productTypes?[indexPath.row - 1] else {
            return UITableViewCell()
        }
        
        cell.configure(category: productType, switchState: stateForSwitch(indexPath: indexPath))
        cell.changedState = { [weak self] newState in
            self?.filterState[productType.id] = newState
            self?.switchesUpdated()
        }
        
        return cell
    }
    
    
}

extension FilterView: UITableViewDelegate {
    
}
