//
//  Extension+Bundle.swift
//  MercadoBitcoin
//
//  Created by NJ Development on 18/05/23.
//

import Foundation

extension Bundle {
    var apiKey: String {
        return self.object(forInfoDictionaryKey: "API_KEY") as! String
    }
    
    var scheme: String {
        return self.object(forInfoDictionaryKey: "SCHEME") as! String
    }
    
    var host: String {
        return self.object(forInfoDictionaryKey: "HOST") as! String
    }
    
    var endpoint: String {
        return self.object(forInfoDictionaryKey: "ENDPOINT") as! String
    }
    
    var title: String {
        return self.object(forInfoDictionaryKey: "TITLE") as! String
    }
}
