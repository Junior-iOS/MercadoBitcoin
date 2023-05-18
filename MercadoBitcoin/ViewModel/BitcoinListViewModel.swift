//
//  BitcoinListViewModel.swift
//  MercadoBitcoin
//
//  Created by NJ Development on 17/05/23.
//

import Foundation
import UIKit

protocol BitcoinListViewModelDelegate: AnyObject {
    func didSelectCoin(_ coin: Bitcoin)
    func didLoadList()
    func didNotLoadList(_ error: NetworkError)
}

final class BitcoinListViewModel: NSObject {
    private let service: NetworkProviderProtocol
    weak var delegate: BitcoinListViewModelDelegate?
    var list: [Bitcoin]?

    init(service: NetworkProviderProtocol = NetworkProvider()) {
        self.service = service
    }

    func fetchBitcoinList() {
        service.execute(.searchList(), expecting: [Bitcoin].self) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let model):
                list = model

                DispatchQueue.main.async {
                    self.delegate?.didLoadList()
                }

            case .failure(let failure):
                delegate?.didNotLoadList(failure)
            }
        }
    }
}

extension BitcoinListViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let list else { return }
        delegate?.didSelectCoin(list[indexPath.row])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(of: BitcoinListTableViewCell.self, for: indexPath) { [weak self] cell in
            guard let self, let list = self.list?[indexPath.row] else { return }
            cell.configure(list: list)
        }
    }
}
