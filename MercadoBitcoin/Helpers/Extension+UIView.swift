//
//  Extension+UIView.swift
//  MercadoBitcoin
//
//  Created by Junior Silva on 09/02/23.
//

import Foundation
import UIKit

internal extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
