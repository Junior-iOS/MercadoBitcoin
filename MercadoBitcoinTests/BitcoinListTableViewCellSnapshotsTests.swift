//
//  BitcoinListTableViewCellTests.swift
//  MercadoBitcoinTests
//
//  Created by NJ Development on 21/05/23.
//

@testable import MercadoBitcoinMock
import Nimble
import Nimble_Snapshots
import Quick

final class BitcoinListTableViewCellSnapshotsTests: QuickSpec {
    private var recording = false

    override func spec() {
        var sut: BitcoinListTableViewCell!
        let list = Bitcoin(exchangeId: "BINANCE", name: "Binance", volume: 20_486_813_096.94)

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
