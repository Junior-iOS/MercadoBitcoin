//
//  ErrorHandler.swift
//  MercadoBitcoin
//
//  Created by NJ Development on 17/05/23.
//

import Foundation
import UIKit

final class ErrorHandler: NSObject {
    static let shared = ErrorHandler()
    private var viewModel = AlertViewModel(networkErrorModel: .noData)

    override private init() {
        super.init()
    }

    func showAlertFor(error: NetworkError?, from controller: MainViewController) {
        if let error {
            viewModel = AlertViewModel(networkErrorModel: error)
        }

        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            controller.errorView.isHidden.toggle()
        }))
        controller.present(alert, animated: true, completion: nil)
    }
}
