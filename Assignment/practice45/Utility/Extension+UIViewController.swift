//
//  Extension+UIViewController.swift
//  practice45
//
//  Created by Anish Agarwal on 07/11/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlertView(titleString: String, messageString: String, actionString: String) {
        
        let alert = UIAlertController(title: titleString, message: messageString, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: actionString, style: UIAlertAction.Style.default, handler: nil))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
