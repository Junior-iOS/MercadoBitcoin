//
//  BaseViewController.swift
//  MercadoBitcoin
//
//  Created by NJ Development on 17/05/23.
//

import Foundation
import UIKit

open class BaseViewController: UIViewController {
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.setGradientColor()
    }
}
