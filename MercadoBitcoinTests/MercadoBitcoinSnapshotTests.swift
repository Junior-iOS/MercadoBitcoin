//
//  MercadoBitcoinSnapshotTests.swift
//  MercadoBitcoinTests
//
//  Created by NJ Development on 17/05/23.
//

@testable import MercadoBitcoinMock
import Nimble
import Nimble_Snapshots
import Quick

final class MercadoBitcoinSnapshotTests: QuickSpec {
    private var recording = false

    override func spec() {
        var sut: MainViewController!

        describe("Opening the application") {
            context("on success") {
                it("loads the screen") {
//                    self.recording = true

                    sut = MainViewController()
                    sut.viewDidLoad()

                    sut.view.translatesAutoresizingMaskIntoConstraints = false
                    sut.view.widthAnchor.constraint(equalToConstant: 500).isActive = true
                    sut.view.heightAnchor.constraint(equalToConstant: 1_000).isActive = true

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
