//
//  BitcoinListViewModel.swift
//  MercadoBitcoin
//
//  Created by Junior Silva on 09/02/23.
//

import Foundation
import UIKit

protocol BitcoinListViewModelDelegate: AnyObject {
    func didSelectCoin(_ coin: Bitcoin)
    func didLoadList()
    func didNotLoadList(_ error: NetworkError)
}

final class BitcoinListViewModel: NSObject {
    
    public weak var delegate: BitcoinListViewModelDelegate?
    public var list: [Bitcoin]?
    
    public func fetchBitcoinList() {
        NetworkProvider.shared.fetchData(.searchList()) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let model):
                self.list = model
                
                DispatchQueue.main.async {
                    self.delegate?.didLoadList()
                }
            case .failure(let failure):
                self.delegate?.didNotLoadList(failure)
            }
        }
    }
}

extension BitcoinListViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let list = list else { return }
        delegate?.didSelectCoin(list[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(of: BitcoinListTableViewCell.self, for: indexPath) { [weak self] cell in
            guard let self = self, let list = self.list?[indexPath.row] else { return }
            cell.configure(list: list)
        }
    }
}
