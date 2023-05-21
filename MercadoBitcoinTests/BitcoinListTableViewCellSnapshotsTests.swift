//
//  BitcoinListTableViewCellTests.swift
//  MercadoBitcoinTests
//
//  Created by Junior Silva on 21/05/23.
//

import XCTest

@testable import MercadoBitcoinMock
import Nimble_Snapshots
import Nimble
import Quick

final class BitcoinListTableViewCellSnapshotsTests: QuickSpec {
    
    var recording = false
    
    override func spec() {
        
        var sut: BitcoinListTableViewCell!
        let list = Bitcoin(exchangeId: "BINANCE", name: "Binance", volume: 20486813096.94)
        
        describe("Opening the application") {
            context("on success") {
                it("loads the screen") {
//                    self.recording = true
                    
                    sut = BitcoinListTableViewCell()
                    sut.configure(list: list)
                    
                    sut.translatesAutoresizingMaskIntoConstraints = false
                    sut.widthAnchor.constraint(equalToConstant: 500).isActive = true
                    sut.heightAnchor.constraint(equalToConstant: 100).isActive = true
                    
                    if self.recording {
                        expect(sut).toEventually(recordSnapshot(), timeout: .seconds(3))
                    } else {
                        expect(sut).toEventually(haveValidSnapshot(), timeout: .seconds(3))
                    }
                }
            }
        }
    }
}
