//
//  Loader.swift
//  practice45
//
//  Created by Anish Agarwal on 07/11/22.
//

import UIKit

class Loader {
     
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.color = UIColor.black
        view.startAnimating()
        
        return view
    }()
    
    func showLoader(_ vc: UIViewController) {
        activityIndicator.center = vc.view.center
        vc.view.addSubview(activityIndicator)
    }
    
    func hideLoader() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.removeFromSuperview()
        }
    }
    
}
