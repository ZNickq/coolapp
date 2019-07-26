//
//  ViewControllerExtension.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 26/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit

extension UIViewController {
    
    //Show a basic alert
    func showAlert(alertText : String, alertMessage : String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        
        self.present(alert, animated: true, completion: nil)
    }
}
