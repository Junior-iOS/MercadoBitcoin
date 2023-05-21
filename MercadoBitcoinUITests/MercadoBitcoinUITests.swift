////
////  MercadoBitcoinUITests.swift
////  MercadoBitcoinUITests
////
////  Created by NJ Development on 16/05/23.
////
//
//import XCTest
//
//final class MercadoBitcoinUITests: XCTestCase {
//    func testExample() throws {
//        let app = XCUIApplication()
//        app.launch()
//
//        app.tables.staticTexts["Binance"].tap()
//        app.navigationBars["BINANCE"].buttons["Back"].tap()
//
//        app.tables.staticTexts["Kraken"].tap()
//        app.navigationBars["KRAKEN"].buttons["Back"].tap()
//
//        app.tables.staticTexts["Bitstamp Ltd."].tap()
//        app.navigationBars["BITSTAMP"].buttons["Back"].tap()
//
//        let binanceCell = app.tables.staticTexts["Binance"]
//        expectation(for: NSPredicate( format: "exists == 1"), evaluatedWith: binanceCell, handler: nil)
//        waitForExpectations(timeout: 5, handler: nil)
//
//        let krakenCell = app.tables.staticTexts["Kraken"]
//        expectation(for: NSPredicate( format: "exists == 1"), evaluatedWith: krakenCell, handler: nil)
//        waitForExpectations(timeout: 5, handler: nil)
//
//        let bitstampCell = app.tables.staticTexts["Bitstamp Ltd."]
//        expectation(for: NSPredicate( format: "exists == 1"), evaluatedWith: bitstampCell, handler: nil)
//        waitForExpectations(timeout: 5, handler: nil)
//    }
//}
