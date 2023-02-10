//
//  BitcoinListView.swift
//  MercadoBitcoin
//
//  Created by Junior Silva on 09/02/23.
//

import Foundation
import UIKit

protocol BitcoinListViewViewDelegate: AnyObject {
    func setBitcoinListView(with bitcoinListView: BitcoinListView, didSelectCoin coin: Bitcoin)
    func errorWasFound(_ error: NetworkError)
}

final class BitcoinListView: UIView {
    
    public let viewModel = BitcoinListViewModel()
    public weak var delegate: BitcoinListViewViewDelegate?
    
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
        tableView.isHidden = true
        tableView.alpha = 0
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
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        addSubviews(tableView, spinner)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

extension BitcoinListView: BitcoinListViewModelDelegate {
    func didNotLoadList(_ error: NetworkError) {
        self.spinner.stopAnimating()
        delegate?.errorWasFound(error)
    }
    
    func didSelectCoin(_ coin: Bitcoin) {
        delegate?.setBitcoinListView(with: self, didSelectCoin: coin)
    }
    
    func didLoadList() {
        tableView.isHidden = false
        tableView.reloadData()

        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
            UIView.animate(withDuration: 0.4) {
                self.spinner.stopAnimating()
                self.tableView.alpha = 1
            }
        })
    }
}
