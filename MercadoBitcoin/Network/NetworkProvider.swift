//
//  NetworkProvider.swift
//  MercadoBitcoin
//
//  Created by NJ Development on 16/05/23.
//

import Foundation

protocol NetworkProviderProtocol: AnyObject {
    func execute<T: Codable>(_ endpoint: Endpoint, expecting type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void)
}

final class NetworkProvider: NetworkProviderProtocol {
    func execute<T: Codable>(_ endpoint: Endpoint, expecting type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = endpoint.url else {
            completion(.failure(.invalidEndpoint))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(endpoint.headerValue, forHTTPHeaderField: endpoint.headerField)

        loadUrlAndDecode(request, completion: completion)
    }

    private func loadUrlAndDecode<T: Decodable>(_ url: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self else { return }

            guard error == nil, let data else {
                executeCompletionHandler(with: .failure(.apiError), completion: completion)
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                executeCompletionHandler(with: .success(decodedResponse), completion: completion)
            } catch {
                executeCompletionHandler(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
    }

    private func executeCompletionHandler<T: Decodable>(with result: Result<T, NetworkError>, completion: @escaping (Result<T, NetworkError>) -> Void) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
