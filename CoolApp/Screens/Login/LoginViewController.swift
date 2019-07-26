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
        
        func view(frame: CGRect) -> LoginSubview {
            switch self {
            case .none:
                return LoginSubview(frame: frame)
            case .initial:
                return UsernamePasswordView(frame: frame)
            case .picker:
                return OptionPickerView(frame: frame)
            case .quickOrder:
                return QuickOrderView(frame: frame)
            }
        }
    }
    
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var containerView: UIView!
    
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
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private var currentView: LoginSubview? = nil;
    
    func updateState() {
        UIView.animate(withDuration: 0.2, animations: {
            self.containerView.subviews.forEach { $0.alpha = 0.0 }
            self.containerView.layoutIfNeeded()
        }) { [weak self] (_) in
            guard let `self` = self else { return }
            self.containerView.subviews.forEach { $0.removeFromSuperview() }
            
            let newView = self.state.view(frame: self.containerView.bounds)
            newView.delegate = self
            self.containerView.addSubview(newView)
            
            self.currentView = newView // Keeps ARC from deallocing
            
            newView.alpha = 0.0
            self.containerView.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.1, animations: {
                newView.alpha = 1.0
                self.containerView.layoutIfNeeded()
            })
            
        }
        
    }
    
}

extension LoginViewController: LoginViewDelegate {
    
    func nextTapped(option: LoginViewOption) {
        switch option {
        case .login:
            state = .picker
        case .quickOrder:
            state = .quickOrder
        case .search:
            performSegue(withIdentifier: "showQuickOrder", sender: self)
        case .dashboards:
            performSegue(withIdentifier: "showDashboard", sender: self)
        }
    }
    
    
}

extension LoginViewController {
    
    func setupAppearance() {
        mainView.clipsToBounds = true
        
        mainView.layer.shadowPath =
            UIBezierPath(roundedRect: mainView.bounds,
                         cornerRadius: mainView.layer.cornerRadius).cgPath
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOpacity = 0.2
        mainView.layer.shadowOffset = CGSize(width: 4, height: 4)
        mainView.layer.shadowRadius = 1
        mainView.layer.masksToBounds = false
    }
    
}
