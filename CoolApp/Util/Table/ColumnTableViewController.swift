//
//  ColumnTableViewController.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 22/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit

class ColumnTableViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var columnedTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        columnedTableView.delegate = self
    }
    
    func columnRatios() -> [SectionedItem] {
        fatalError("This method must be implemented in a superclass!")
    }
    
    
    // UITableViewDelegate methods
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else {
            return nil // More than one section header is not supported at the moment
        }
        
        let ratios = self.columnRatios()
        let height = self.tableView(tableView, heightForHeaderInSection: section)
        
        let columnHeader = ColumnTableViewHeader(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: height))
        
        columnHeader.loadRatios(ratios: ratios)
        
        return columnHeader;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0;
    }
    
}
