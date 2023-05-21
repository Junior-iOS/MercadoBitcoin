//
//  BitcoinListView.swift
//  MercadoBitcoin
//
//  Created by NJ Development on 17/05/23.
//

import Foundation
import UIKit

final class BitcoinListView: UIView {
    let viewModel = BitcoinListViewModel()

//    let spinner: UIActivityIndicatorView = {
//        let spinner = UIActivityIndicatorView(style: .large)
//        spinner.hidesWhenStopped = true
//        spinner.color = .systemOrange
////        spinner.startAnimating()
//        spinner.translatesAutoresizingMaskIntoConstraints = false
//        return spinner
//    }()

    let tableView: UITableView = {
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
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {
        addSubviews(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)

//            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
//            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
