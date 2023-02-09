//
//  DetailViewController.swift
//  MercadoBitcoin
//
//  Created by Junior Silva on 09/02/23.
//

import UIKit

final class DetailViewController: UIViewController {
    
    var coin: Bitcoin?
    private lazy var detailsView = DetailsView(coin: coin)

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        view.backgroundColor = .systemBackground
        defaultBackButton()
        title = coin?.exchangeId
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.addSubview(detailsView)
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailsView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailsView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}
