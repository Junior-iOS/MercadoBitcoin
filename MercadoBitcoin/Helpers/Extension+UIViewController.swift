//
//  Extension+UIViewController.swift
//  MercadoBitcoin
//
//  Created by NJ Development on 17/05/23.
//

import Foundation
import UIKit

extension UIViewController {
    func defaultBackButton(target: Any? = nil, action: Selector? = nil) {
        let img = UIImage(systemName: "chevron.backward")
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: img,
                                                           style: .plain,
                                                           target: target ?? self.navigationController,
                                                           action: action ?? #selector(navigationController?.popViewController(animated:)))
    }
}
