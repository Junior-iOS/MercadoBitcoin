//
//  MainViewController.swift
//  MercadoBitcoin
//
//  Created by Junior Silva on 08/02/23.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let bitcoinListView = BitcoinListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
    }
    
    private func setup() {
        view.backgroundColor = .systemBackground
        
        title = "Mercado Bitcoin"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    private func setupConstraints() {
        view.addSubview(bitcoinListView)
        bitcoinListView.translatesAutoresizingMaskIntoConstraints = false
        bitcoinListView.delegate = self
        
        NSLayoutConstraint.activate([
            bitcoinListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bitcoinListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            bitcoinListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            bitcoinListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension MainViewController: BitcoinListViewViewDelegate {
    func setBitcoinListView(with bitcoinListView: BitcoinListView, didSelectEpisode coin: Bitcoin) {
        let vc = DetailViewController()
        vc.coin = coin
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
