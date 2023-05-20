//
//  Extension+Bundle.swift
//  MercadoBitcoin
//
//  Created by NJ Development on 18/05/23.
//

import Foundation

extension Bundle {
    var apiKey: String {
        guard let apiKey = self.object(forInfoDictionaryKey: "API_KEY") as? String else { return "" }
        return apiKey
    }
    
    var scheme: String {
        guard let scheme = self.object(forInfoDictionaryKey: "SCHEME") as? String else { return ""}
        return scheme
    }
    
    var host: String {
        guard let host = self.object(forInfoDictionaryKey: "HOST") as? String else { return ""}
        return host
    }
    
    var endpoint: String {
        guard let endpoint = self.object(forInfoDictionaryKey: "ENDPOINT") as? String else { return ""}
        return endpoint
    }
    
    var title: String {
        guard let title = self.object(forInfoDictionaryKey: "TITLE") as? String else { return ""}
        return title
    }
}
