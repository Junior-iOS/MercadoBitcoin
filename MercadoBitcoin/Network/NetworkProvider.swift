//
//  NetworkProvider.swift
//  MercadoBitcoin
//
//  Created by Junior Silva on 08/02/23.
//

import Foundation

protocol NetworkProviderProtocol: AnyObject {
    func fetchData(_ endpoint: Endpoint, completion: @escaping (Result<[Bitcoin], NetworkError>) -> Void)
}

final class NetworkProvider: NetworkProviderProtocol {
    private init() {}
    static let shared = NetworkProvider()
    
    func fetchData(_ endpoint: Endpoint, completion: @escaping (Result<[Bitcoin], NetworkError>) -> Void) {
        guard let url = endpoint.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("C1990D35-EB06-4C4E-AF49-E54D00A5BD02", forHTTPHeaderField: "X-CoinAPI-Key")
        
        loadUrlAndDecode(request, completion: completion)
    }
    
    private func loadUrlAndDecode<T: Decodable>(_ url: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            guard error == nil, let data = data else {
                self.executeCompletionHandler(with: .failure(.apiError), completion: completion)
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                self.executeCompletionHandler(with: .success(decodedResponse), completion: completion)
            } catch {
                self.executeCompletionHandler(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
    }
    
    private func executeCompletionHandler<T: Decodable>(with result: Result<T, NetworkError>, completion: @escaping (Result<T, NetworkError>) -> Void) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
