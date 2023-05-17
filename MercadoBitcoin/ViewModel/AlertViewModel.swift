//
//  AlertViewModel.swift
//  MercadoBitcoin
//
//  Created by NJ Development on 17/05/23.
//

import Foundation
import UIKit

struct AlertViewModel {
    
    // MARK: - Properties
    var title: String
    var message: String
        
    // MARK: - Init
    init(networkErrorModel: NetworkError) {
        switch networkErrorModel {
        case .apiError:
            title = "Bad URL"
            message = "There is something wrong with the URL you are trying to access. Please try again in a few minutes or contact support if the problem"
        case .invalidEndpoint:
            title = "Not found"
            message = "The resource you are trying to reach does not exist."
        case .invalidResponse:
            title = "Invalid response"
            message = "Unexpected response found. If the problem persists, please contact support."
        case .noData:
            title = "No data found"
            message = "The resource you are trying to reach does not exist."
        case .serializationError:
            title = "Serialization Error"
            message = "Please check your model object."
        }
    }
}

