//
//  QuickOrderView.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 22/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit

class QuickOrderView: LoginSubview {

    @IBOutlet weak var restaurantSearchTextField: RestaurantSearchTextField!
    @IBOutlet weak var restaurantDate: UITextField!
    
    private let datePicker = UIDatePicker()
    
    override func setupAppearance() {
        setupDatePicker()
    
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
    
    
}
