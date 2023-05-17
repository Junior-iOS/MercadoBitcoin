//
//  MainViewController.swift
//  MercadoBitcoin
//
//  Created by NJ Development on 17/05/23.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let bitcoinListView = BitcoinListView()
    private let errorView = ErrorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.tintColor = .systemBackground
    }
    
    private func setup() {
        view.backgroundColor = .systemBackground
        
        title = Bundle.main.title
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
    
    private func setupErrorView() {
        view.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.delegate = self
        
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            errorView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            errorView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension MainViewController: BitcoinListViewViewDelegate {
    func errorWasFound(_ error: NetworkError) {
        DispatchQueue.main.async {
            ErrorHandler.shared.showAlertFor(error: error, from: self)
            self.setupErrorView()
        }
    }
    
    func setBitcoinListView(with bitcoinListView: BitcoinListView, didSelectCoin coin: Bitcoin) {
        let vc = DetailViewController()
        vc.coin = coin
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: ErrorViewDelegate {
    func didTapTryAgain() {
        DispatchQueue.main.async {
            self.errorView.removeFromSuperview()
            self.bitcoinListView.viewModel.fetchBitcoinList()
        }
    }
}
