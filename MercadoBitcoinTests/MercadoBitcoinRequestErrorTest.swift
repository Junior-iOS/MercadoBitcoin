//
//  MercadoBitcoinRequestErrorTest.swift
//  MercadoBitcoinTests
//
//  Created by NJ Development on 18/05/23.
//

import XCTest

@testable import MercadoBitcoinMock

class MercadoBitcoinRequestErrorTest: XCTestCase {
    func testLocalizedDescription() {
        XCTAssertEqual(NetworkError.apiError.localizedDescription, "Failed to fetch data")
        XCTAssertEqual(NetworkError.invalidEndpoint.localizedDescription, "invalid Endpoint")
        XCTAssertEqual(NetworkError.invalidResponse.localizedDescription, "invalid Response")
        XCTAssertEqual(NetworkError.noData.localizedDescription, "No Data")
        XCTAssertEqual(NetworkError.serializationError.localizedDescription, "Failed to Decode data")
    }
}
