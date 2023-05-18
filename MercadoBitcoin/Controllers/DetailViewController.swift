//
//  DetailViewController.swift
//  MercadoBitcoin
//
//  Created by NJ Development on 17/05/23.
//

import UIKit

final class DetailViewController: BaseViewController {
    var coin: Bitcoin?
    private lazy var detailsView = DetailsView(coin: coin)
    
    override func loadView() {
        super.loadView()
        self.view = detailsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        view.backgroundColor = .systemBackground
        defaultBackButton()
        title = coin?.exchangeId
    }
}
