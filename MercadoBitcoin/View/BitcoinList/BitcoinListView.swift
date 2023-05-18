//
//  BitcoinListView.swift
//  MercadoBitcoin
//
//  Created by NJ Development on 17/05/23.
//

import Foundation
import UIKit

protocol BitcoinListViewViewDelegate: AnyObject {
    func setBitcoinListView(with bitcoinListView: BitcoinListView, didSelectCoin coin: Bitcoin)
    func errorWasFound(_ error: NetworkError)
}

final class BitcoinListView: UIView {
    let viewModel = BitcoinListViewModel()
    weak var delegate: BitcoinListViewViewDelegate?

    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.color = .systemOrange
        spinner.startAnimating()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(cellClass: BitcoinListTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 5
        tableView.clipsToBounds = true
        tableView.backgroundColor = UIColor(red: 0.22, green: 0.22, blue: 0.22, alpha: 1.00)
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupTableView()
        viewModel.fetchBitcoinList()
        viewModel.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        setupConstraints()
    }

    private func setupConstraints() {
        addSubviews(tableView, spinner)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

extension BitcoinListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let coin = viewModel.list?[indexPath.row] else { return }
        delegate?.setBitcoinListView(with: self, didSelectCoin: coin)
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

extension BitcoinListView: BitcoinListViewModelDelegate {
    func didNotLoadList(_ error: NetworkError) {
        self.spinner.stopAnimating()
        delegate?.errorWasFound(error)
    }

    func didLoadList() {
        tableView.reloadData()
        spinner.stopAnimating()
    }
}
