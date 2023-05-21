//
//  MercadoBitcoinTests.swift
//  MercadoBitcoinTests
//
//  Created by NJ Development on 16/05/23.
//

@testable import MercadoBitcoinMock
import XCTest

final class MercadoBitcoinTests: XCTestCase {
    private var mockService: MockNetworkProvider!
    private var sut: BitcoinListViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockService = MockNetworkProvider()
        sut = BitcoinListViewModel(service: mockService)
    }

    override func tearDownWithError() throws {
        mockService = nil
        sut = nil
        try super.tearDownWithError()
    }

    func testFetchBitcoinList() {
        let expectation = XCTestExpectation(description: "Request successfully")
        let mockModel = Bitcoin(exchangeId: "BINANCE", name: "Binance", volume: 20_486_813_096.94)

        sut.fetchBitcoinList()
        XCTAssertNotNil(mockModel)

        expectation.fulfill()
        wait(for: [expectation], timeout: 10)
    }
}

class MockNetworkProvider: NetworkProviderProtocol {
    
    func execute<T>(_ endpoint: MercadoBitcoinMock.MercadoBitcoinEndpoint, expecting type: T.Type, completion: @escaping (Result<T, MercadoBitcoinMock.NetworkError>) -> Void) where T : Decodable, T : Encodable { }
    
    var mockResult: ((Result<[MercadoBitcoinMock.Bitcoin], MercadoBitcoinMock.NetworkError>) -> Void)!
    
}
