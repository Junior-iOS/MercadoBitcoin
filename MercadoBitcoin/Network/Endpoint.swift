//
//  Endpoint.swift
//  MercadoBitcoin
//
//  Created by NJ Development on 16/05/23.
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
