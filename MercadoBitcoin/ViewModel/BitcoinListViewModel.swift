//
//  BitcoinListViewModel.swift
//  MercadoBitcoin
//
//  Created by NJ Development on 17/05/23.
//

import Foundation
import UIKit

protocol BitcoinListViewModelDelegate: AnyObject {
    func didLoadList()
    func didNotLoadList(_ error: NetworkError)
}

final class BitcoinListViewModel: NSObject {
    private let service: NetworkProviderProtocol
    weak var delegate: BitcoinListViewModelDelegate?
    var list: [Bitcoin]? {
        didSet {
            self.delegate?.didLoadList()
        }
    }

    init(service: NetworkProviderProtocol = NetworkProvider()) {
        self.service = service
    }

    func fetchBitcoinList() {
        service.execute(.searchList(), expecting: [Bitcoin].self) { [weak self] result in
            guard let self else { return }

            switch result {
            case .success(let model):
                list = model

            case .failure(let failure):
                delegate?.didNotLoadList(failure)
            }
        }
    }
    
    func routeTo(_ viewController: UIViewController, with coin: Bitcoin) {
        let vc = DetailViewController()
        vc.coin = coin
        vc.navigationItem.largeTitleDisplayMode = .never
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
