//
//  MainViewController.swift
//  MercadoBitcoin
//
//  Created by NJ Development on 17/05/23.
//

import UIKit

final class MainViewController: BaseViewController {
    
    // MARK: - Properties
    private let bitcoinListView = BitcoinListView()
    private let errorView = ErrorView()
    private let viewModel = BitcoinListViewModel()

    // MARK: - Life cycle
    override func loadView() {
        super.loadView()
        self.view = bitcoinListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
        
        viewModel.delegate = self
        viewModel.fetchBitcoinList()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.tintColor = .systemOrange
    }

    // MARK: - Private methods
    private func setup() {
        view.backgroundColor = .systemBackground

        title = Bundle.main.title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always

        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    private func setupTableView() {
        bitcoinListView.tableView.dataSource = self
        bitcoinListView.tableView.delegate = self
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

// MARK: - UITableView Delegate and Datasource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let coin = viewModel.list?[indexPath.row] else { return }
        viewModel.routeTo(self, with: coin)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.list?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(of: BitcoinListTableViewCell.self, for: indexPath) { [weak self] cell in
            guard let self, let list = self.viewModel.list?[indexPath.row] else { return }
            cell.configure(list: list)
        }
    }
}

// MARK: - BitcoinListView delegate
extension MainViewController: BitcoinListViewModelDelegate {
    func didNotLoadList(_ error: NetworkError) {
        bitcoinListView.spinner.stopAnimating()
        
        DispatchQueue.main.async {
            ErrorHandler.shared.showAlertFor(error: error, from: self)
            self.setupErrorView()
        }
    }

    func didLoadList() {
        DispatchQueue.main.async {
            self.bitcoinListView.tableView.reloadData()
            self.bitcoinListView.spinner.stopAnimating()
        }
    }
}

// MARK: - ErrorView Delegate
extension MainViewController: ErrorViewDelegate {
    func didTapTryAgain() {
        DispatchQueue.main.async {
            self.errorView.removeFromSuperview()
            self.viewModel.fetchBitcoinList()
        }
    }
}
