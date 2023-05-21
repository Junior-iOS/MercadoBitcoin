//
//  DetailsViewSnapshotTests.swift
//  MercadoBitcoinTests
//
//  Created by NJ Development on 21/05/23.
//

@testable import MercadoBitcoinMock
import Nimble_Snapshots
import Nimble
import Quick

final class DetailsViewSnapshotTests: QuickSpec {
    
    var recording = false
    
    override func spec() {
        
        var sut: DetailViewController!
        let coin = Bitcoin(exchangeId: "BINANCE", name: "Binance", volume: 20486813096.94)
        
        describe("Opening the application") {
            context("on success") {
                it("loads the screen") {
//                    self.recording = true
                    
                    sut = DetailViewController()
                    sut.coin = coin
                    sut.setup()
                    
                    sut.detailsView.translatesAutoresizingMaskIntoConstraints = false
                    sut.detailsView.widthAnchor.constraint(equalToConstant: 500).isActive = true
                    sut.detailsView.heightAnchor.constraint(equalToConstant: 1000).isActive = true
                    
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
