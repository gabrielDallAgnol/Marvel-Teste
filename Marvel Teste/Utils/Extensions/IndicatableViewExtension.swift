//
//  File.swift
//  CodeMoney
//
//  Created by Palmsoft  on 09/08/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit
import PKHUD

protocol IndicatableView: class {
    func showActivityIndicator()
    func hideActivityIndicator()
}

extension IndicatableView where Self: UIViewController {
    
    func showActivityIndicator() {
        ActivityIndicator.shared.showActivityIndicator(in: view)
    }
    
    func hideActivityIndicator() {
        ActivityIndicator.shared.hideActivityIndicator()
    }
}
