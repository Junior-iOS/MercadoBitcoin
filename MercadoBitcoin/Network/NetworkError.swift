//
//  NetworkError.swift
//  MercadoBitcoin
//
//  Created by NJ Development on 16/05/23.
//

import Foundation

enum NetworkError: Error, CustomNSError {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError

    var localizedDescription: String {
        switch self {
        case .apiError:
            return "Failed to fetch data"
        case .invalidEndpoint:
            return "invalid Endpoint"
        case .invalidResponse:
            return "invalid Response"
        case .noData:
            return "No Data"
        case .serializationError:
            return "Failed to Decode data"
        }
    }
}
