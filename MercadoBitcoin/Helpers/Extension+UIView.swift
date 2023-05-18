//
//  Extension+UIView.swift
//  MercadoBitcoin
//
//  Created by NJ Development on 17/05/23.
//

import Foundation
import UIKit

internal extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }

    static var identifier: String {
        String(describing: self)
    }

    func setGradientColor() {
        let gradientLayer = CAGradientLayer()
        let firstColor = UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.00)
        let secondColor = UIColor(red: 0.22, green: 0.22, blue: 0.22, alpha: 1.00)
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.startPoint = CGPoint.zero
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
