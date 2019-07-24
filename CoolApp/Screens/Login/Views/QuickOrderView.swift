//
//  QuickOrderView.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 22/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit
import SearchTextField

class QuickOrderView: LoginSubview {

    @IBOutlet weak var restaurantSearchTextField: SearchTextField!
    @IBOutlet weak var restaurantDate: UITextField!
    
    private let datePicker = UIDatePicker()
    
    override func setupAppearance() {
        setupDatePicker()
        
        restaurantSearchTextField.theme.font = UIFont.systemFont(ofSize: 15)
    
        restaurantSearchTextField.userStoppedTypingHandler = {
            if let criteria = self.restaurantSearchTextField.text {
                if criteria.count > 1 {
                    self.restaurantSearchTextField.showLoadingIndicator()
                    
                    self.searchMoreItemsInBackground(criteria) { results in
                        // Set new items to filter
                        self.restaurantSearchTextField.filterItems(results)
                        
                        // Hide loading indicator
                        self.restaurantSearchTextField.stopLoadingIndicator()
                    }
                }
            }
        }
        
        let item = restaurantSearchTextField.inputAssistantItem;
        item.leadingBarButtonGroups = [];
        item.trailingBarButtonGroups = [];
    }
    
    @objc func dateDoneTapped() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        restaurantDate.text = formatter.string(from: datePicker.date)
        
        endEditing(true)
    }
    
    @objc func dateCancelTapped() {
        endEditing(true)
    }
    
    func setupDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dateDoneTapped));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dateCancelTapped));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        restaurantDate.inputAccessoryView = toolbar
        restaurantDate.inputView = datePicker
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        delegate?.nextTapped(option: .search)
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
