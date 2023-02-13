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
        urlComponents.scheme = Bundle.main.scheme
        urlComponents.host = Bundle.main.host
        urlComponents.path = path
        return urlComponents.url
    }
    
    static func searchList() -> Endpoint {
        Endpoint(path: Bundle.main.endpoint)
    }
}
