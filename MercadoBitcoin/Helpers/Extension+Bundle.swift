//
//  Extension+Bundle.swift
//  MercadoBitcoin
//
//  Created by Junior Silva on 10/02/23.
//

import Foundation

extension Bundle {
    var apiKey: String {
        return self.object(forInfoDictionaryKey: "API_KEY") as! String
    }
}
