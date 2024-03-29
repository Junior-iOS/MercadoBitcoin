//
//  MainViewController.swift
//  MercadoBitcoin
//
//  Created by NJ Development on 17/05/23.
//

import UIKit

final class MainViewController: BaseViewController {
    // MARK: - Properties
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.color = .systemOrange
        spinner.startAnimating()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()

    private let bitcoinListView = BitcoinListView()
    let errorView = ErrorView()
    private let viewModel: BitcoinListViewModel

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setupTableView()

        self.viewModel.delegate = self
        self.viewModel.fetchBitcoinList()

        self.errorView.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.tintColor = .systemOrange
    }

    init(_ viewModel: BitcoinListViewModel = BitcoinListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    // MARK: - Private methods
    private func setup() {
        view.backgroundColor = .systemBackground

        title = Bundle.main.title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always

        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true

        addComponents()
    }

    private func addComponents() {
        view.addSubviews(bitcoinListView, spinner, errorView)

        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.delegate = self
        bitcoinListView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            errorView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            errorView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            bitcoinListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bitcoinListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bitcoinListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bitcoinListView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            spinner.centerXAnchor.constraint(equalTo: bitcoinListView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: bitcoinListView.centerYAnchor)
        ])
    }

    private func setupTableView() {
        bitcoinListView.tableView.dataSource = self
        bitcoinListView.tableView.delegate = self
    }

    private func setupErrorView() {
        errorView.isHidden.toggle()
    }
}

// MARK: - UITableView Delegate and Datasource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let coin = viewModel.list?[indexPath.row] else { return }
        viewModel.route(from: self, with: coin)
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
        spinner.stopAnimating()

        DispatchQueue.main.async {
            self.setupErrorView()
        }
    }

    func didLoadList() {
        DispatchQueue.main.async {
            self.bitcoinListView.tableView.reloadData()
            self.spinner.stopAnimating()
        }
    }
}

// MARK: - ErrorView Delegate
extension MainViewController: ErrorViewDelegate {
    func didTapTryAgain() {
        DispatchQueue.main.async {
            self.errorView.isHidden.toggle()
            self.viewModel.fetchBitcoinList()
        }
    }
}
