//
//  Exchanges.swift
//  MercadoBitcoin
//
//  Created by Junior Silva on 08/02/23.
//

import Foundation

enum Exchange {
    struct Response: Codable {
        let results: [Bitcoin]
    }
}

struct Bitcoin: Codable {
    let exchangeId: String?
    let name: String?
    let volume: Double?
    
    enum CodingKeys: String, CodingKey {
        case exchangeId = "exchange_id"
        case name
        case volume = "volume_1day_usd"
    }
}

