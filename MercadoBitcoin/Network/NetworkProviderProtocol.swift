//
//  NetworkProviderProtocol.swift
//  MercadoBitcoin
//
//  Created by NJ Development on 21/05/23.
//

import Foundation

protocol NetworkProviderProtocol: AnyObject {
    func execute<T: Codable>(_ endpoint: MercadoBitcoinEndpoint, expecting type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void)
}
