//
//  LoginSubview.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 22/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit

enum LoginViewOption {
    case login, quickOrder, dashboards, search
}

protocol LoginViewDelegate: class{
    func nextTapped(option: LoginViewOption)
}

class LoginSubview: NibView {
    weak var delegate: LoginViewDelegate?
}
