//
//  MercadoBitcoinScreen.swift
//  MercadoBitcoinUITests
//
//  Created by Junior Silva on 09/02/23.
//

import XCTest

class MercadoBitcoinScreen {
    private let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    // MARK: - LOGO VIEW
    var listViewTitleLabel: XCUIElement {
        app.otherElements[ScreenIdentifier.ListView.title.rawValue]
    }
    
    var listViewExchangeIdLabel: XCUIElement {
        app.otherElements[ScreenIdentifier.ListView.exchangeId.rawValue]
    }
    
    var listViewNameLabel: XCUIElement {
        app.otherElements[ScreenIdentifier.ListView.nameLabel.rawValue]
    }
    
    var listViewVolumeLabel: XCUIElement {
        app.otherElements[ScreenIdentifier.ListView.volumeLabel.rawValue]
    }
}

