//
//  ActivityIndicator.swift
//  CodeMoney
//
//  Created by Palmsoft  on 13/08/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit

final class ActivityIndicator {
    static let shared = ActivityIndicator()
    
    var activityIndicator: UIActivityIndicatorView!
    
    func showActivityIndicator(in view: UIView) {
        if activityIndicator == nil {
            activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
            activityIndicator.hidesWhenStopped = true
            activityIndicator.color = .gray
            activityIndicator.center = view.center
            view.addSubview(activityIndicator)
            
            
        }
        
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
}
