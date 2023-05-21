//
//  Extension+Bundle.swift
//  MercadoBitcoin
//
//  Created by NJ Development on 18/05/23.
//

import Foundation

extension Bundle {
    var apiKey: String {
        object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
    }
    
    var scheme: String {
        object(forInfoDictionaryKey: "SCHEME") as? String ?? ""
    }
    
    var host: String {
        object(forInfoDictionaryKey: "HOST") as? String ?? ""
    }
    
    var endpoint: String {
        object(forInfoDictionaryKey: "ENDPOINT") as? String ?? ""
    }
    
    var title: String {
        object(forInfoDictionaryKey: "TITLE") as? String ?? ""
    }
}
