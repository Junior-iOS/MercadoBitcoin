//
//  Endpoint.swift
//  MercadoBitcoin
//
//  Created by Junior Silva on 08/02/23.
//

import Foundation

struct Endpoint {
    let path: String
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "rest.coinapi.io"
        urlComponents.path = path
        return urlComponents.url
    }
    
    static func searchList() -> Endpoint {
        Endpoint(path: "/v1/exchanges")
    }
}
