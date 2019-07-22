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
    
    @IBAction func loginTapped(_ sender: Any) {
        delegate?.nextTapped(option: .login)
    }
}
