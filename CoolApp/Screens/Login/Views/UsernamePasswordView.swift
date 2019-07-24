//
//  UsernamePasswordView.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 22/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit

class UsernamePasswordView: LoginSubview {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func loginTapped(_ sender: Any) {
        
        guard passwordField.text?.count ?? 0 > 0 else {
            passwordField.layer.borderColor = UIColor.red.cgColor
            passwordField.layer.borderWidth = 1.0
            return
        }
        
        delegate?.nextTapped(option: .login)
    }
    
    override func setupAppearance() {
        super.setupAppearance()
        
        loginButton.layer.cornerRadius = 4.0
    }
}
