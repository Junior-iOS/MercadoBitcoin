//
//  DetailViewController.swift
//  MercadoBitcoin
//
//  Created by Junior Silva on 09/02/23.
//

import UIKit

final class DetailViewController: UIViewController {
    
    var coin: Bitcoin?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemOrange
        defaultBackButton()
        print(coin)
    }

}
