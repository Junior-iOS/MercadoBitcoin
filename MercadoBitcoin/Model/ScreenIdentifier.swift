//
//  ScreenIdentifier.swift
//  MercadoBitcoin
//
//  Created by Junior Silva on 09/02/23.
//

import Foundation

struct ScreenIdentifier {
    enum ListView: String {
        case title
        case exchangeId
        case nameLabel
        case volumeLabel
    }
    
    enum DetailView: String {
        case imageView
        case nameLabel
        case volumeLabel
    }
}
