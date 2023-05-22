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
            DispatchQueue.main.async {
                guard let self else { return }

                switch result {
                case .success(let model):
                    self.list = model

                case .failure(let failure):
                    self.delegate?.didNotLoadList(failure)
                }
            }
        }
    }

    func route(from viewController: UIViewController, with coin: Bitcoin) {
        let vc = DetailViewController()
        vc.coin = coin
        vc.navigationItem.largeTitleDisplayMode = .never
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
