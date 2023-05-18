//
//  Extension+Bundle.swift
//  MercadoBitcoin
//
//  Created by NJ Development on 18/05/23.
//

import Foundation

extension Bundle {
    var apiKey: String {
        self.object(forInfoDictionaryKey: "API_KEY") as! String
    }

    var scheme: String {
        self.object(forInfoDictionaryKey: "SCHEME") as! String
    }

    var host: String {
        self.object(forInfoDictionaryKey: "HOST") as! String
    }

    var endpoint: String {
        self.object(forInfoDictionaryKey: "ENDPOINT") as! String
    }

    var title: String {
        self.object(forInfoDictionaryKey: "TITLE") as! String
    }
}
