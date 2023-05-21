//
//  DetailViewController.swift
//  MercadoBitcoin
//
//  Created by NJ Development on 17/05/23.
//

import UIKit

final class DetailViewController: BaseViewController {
    // MARK: - Properties
    var coin: Bitcoin?
    lazy var detailsView = DetailsView(coin: coin)
    
    // MARK: - Life cycle
    override func loadView() {
        super.loadView()
        self.view = detailsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Private Methods
    func setup() {
        view.backgroundColor = .systemBackground
        defaultBackButton()
        title = coin?.exchangeId
    }
}
