//
//  MercadoBitcoinSnapshotTests.swift
//  MercadoBitcoinTests
//
//  Created by Junior Silva on 17/05/23.
//

@testable import MercadoBitcoin
import SnapshotTesting
import XCTest

final class MercadoBitcoinSnapshotTests: XCTestCase {
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }

    private var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }

    func testMainView() {
        let size = CGSize(width: screenWidth, height: screenHeight)
        let view = MainViewController()

        assertSnapshot(matching: view, as: .image(size: size))
    }

    func testDetailView() {
        let size = CGSize(width: screenWidth, height: screenHeight)
        let view = DetailViewController()

        assertSnapshot(matching: view, as: .image(size: size))
    }
}
