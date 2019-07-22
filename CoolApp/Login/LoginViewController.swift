//
//  ViewController.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 22/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    enum LoginFlowState {
        case none, initial, picker, quickOrder
        
        var view: LoginSubview {
            switch self {
            case .none:
                return LoginSubview()
            case .initial:
                return UsernamePasswordView()
            case .picker:
                return OptionPickerView()
            case .quickOrder:
                return QuickOrderView()
            }
        }
    }
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    private var state: LoginFlowState = .none {
        didSet {
            updateState()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        state = .initial
    }

    private var currentView: LoginSubview? = nil;
    
    func updateState() {
        for each in containerView.subviews {
            each.removeFromSuperview()
        }
        
        let newView = state.view
        
        containerView.addSubview(newView.loadNib())
        
        newView.delegate = self
        
        currentView = newView // Keeps ARC from deallocing
    }
    
}

extension LoginViewController: LoginViewDelegate {
    
    func nextTapped(option: LoginViewOption) {
        switch option {
        case .login:
            state = .picker
        case .quickOrder:
            state = .quickOrder
        default:
            fatalError("Not implemented yet!!")
        }
    }
    
    
}

extension LoginViewController {
    
    func setupAppearance() {
        mainView.beautify()
    }
    
}


extension UIView {
    
    func beautify() {
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 5.0
        clipsToBounds = true
        
        layer.shadowPath =
            UIBezierPath(roundedRect: bounds,
                         cornerRadius: layer.cornerRadius).cgPath
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowRadius = 1
        layer.masksToBounds = false
    }
}
