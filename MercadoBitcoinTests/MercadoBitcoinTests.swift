//
//  MercadoBitcoinTests.swift
//  MercadoBitcoinTests
//
//  Created by NJ Development on 16/05/23.
//

import XCTest
@testable import MercadoBitcoin

final class MercadoBitcoinTests: XCTestCase {
    
    var mockService: MockNetworkProvider!
    var sut: BitcoinListViewModel!
    
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
        let mockModel = Bitcoin(exchangeId: "BINANCE", name: "Binance", volume: 20486813096.94)
        
        sut.fetchBitcoinList()
        XCTAssertNotNil(mockModel)
        
        expectation.fulfill()
        wait(for: [expectation], timeout: 10)
    }
    
}

class MockNetworkProvider: NetworkProviderProtocol {
    
    var mockResult: ((Result<[MercadoBitcoin.Bitcoin], MercadoBitcoin.NetworkError>) -> Void)!
    
    func fetchData(_ endpoint: MercadoBitcoin.Endpoint, completion: @escaping (Result<[MercadoBitcoin.Bitcoin], MercadoBitcoin.NetworkError>) -> Void) {
        mockResult = completion
    }
    
}
