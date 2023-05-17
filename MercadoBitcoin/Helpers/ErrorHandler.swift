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
    
    private override init() {
        super.init()
    }
    
    public func showAlertFor(error: NetworkError?, from controller: UIViewController) {
        var viewModel: AlertViewModel!
        
        if let error = error {
            viewModel = AlertViewModel.init(networkErrorModel: error)
        }
        
        let alert = UIAlertController.init(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: NSLocalizedString("ok", comment: "Ok"), style: .default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
}
