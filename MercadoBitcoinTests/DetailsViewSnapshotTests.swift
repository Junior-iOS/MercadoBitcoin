//
//  DetailsViewSnapshotTests.swift
//  MercadoBitcoinTests
//
//  Created by NJ Development on 21/05/23.
//

@testable import MercadoBitcoinMock
import Nimble
import Nimble_Snapshots
import Quick

final class DetailsViewSnapshotTests: QuickSpec {
    private var recording = false

    override func spec() {
        var sut: DetailViewController!
        let coin = Bitcoin(exchangeId: "BINANCE", name: "Binance", volume: 20_486_813_096.94)

        describe("Opening the application") {
            context("on success") {
                it("loads the screen") {
//                    self.recording = true

                    sut = DetailViewController()
                    sut.coin = coin
                    sut.setup()

                    sut.detailsView.translatesAutoresizingMaskIntoConstraints = false
                    sut.detailsView.widthAnchor.constraint(equalToConstant: 500).isActive = true
                    sut.detailsView.heightAnchor.constraint(equalToConstant: 1_000).isActive = true

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
