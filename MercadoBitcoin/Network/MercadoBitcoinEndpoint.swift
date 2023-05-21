//
//  Endpoint.swift
//  MercadoBitcoin
//
//  Created by NJ Development on 16/05/23.
//

import Foundation

struct MercadoBitcoinEndpoint {
    let path: String
    let method: String

    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = Bundle.main.scheme
        urlComponents.host = Bundle.main.host
        urlComponents.path = path
        return urlComponents.url
    }
    
    var headerValue: String {
        Bundle.main.apiKey
    }
    
    var headerField: String {
        "X-CoinAPI-Key"
    }

    static func searchList() -> Self {
        Self(path: Bundle.main.endpoint, method: "GET")
    }
}
