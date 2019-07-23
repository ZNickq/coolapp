//
//  QuickOrderViewController.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 23/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit

class QuickOrderViewController: ColumnTableViewController {

    @IBOutlet weak var bigRestaurantView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.columnedTableView.dataSource = self
        self.columnedTableView.register(UINib(nibName: "QuickOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "aCell")
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }

}

extension QuickOrderViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "aCell") else {
            return UITableViewCell(style: .default, reuseIdentifier: "aCell")
        }
        return cell;
    }
    
    
}
