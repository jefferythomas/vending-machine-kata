//
//  VendingMachineAcceptCoinsTests.swift
//  VendingMachineTests
//
//  Created by Jeffery Thomas on 8/26/15.
//  Copyright © 2015 JLT Source. All rights reserved.
//

import XCTest
@testable import VendingMachine

class VendingMachineAcceptCoinsTests: XCTestCase {

    var vendingMachine = VendingMachine()

    override func setUp() {
        super.setUp()
        vendingMachine = VendingMachine()
    }

    func testNoCoinsInVendingMachine() {
        XCTAssertEqual(vendingMachine.display, "INSERT COIN")
        XCTAssertEqual(vendingMachine.coinsInCoinReturn, [])
    }

    func testReturnUnknownCoin() {
        vendingMachine.addCoin(.Unknown)

        XCTAssertEqual(vendingMachine.display, "INSERT COIN")
        XCTAssertEqual(vendingMachine.coinsInCoinReturn, [.Unknown])
    }

    func testAcceptNickel() {
        vendingMachine.addCoin(.Nickel)

        XCTAssertEqual(vendingMachine.display, "$0.05")
        XCTAssertEqual(vendingMachine.coinsInCoinReturn, [])
    }

    func testAcceptDime() {
        vendingMachine.addCoin(.Dime)

        XCTAssertEqual(vendingMachine.display, "$0.10")
        XCTAssertEqual(vendingMachine.coinsInCoinReturn, [])
    }

    func testAcceptQuarter() {
        vendingMachine.addCoin(.Quarter)

        XCTAssertEqual(vendingMachine.display, "$0.25")
        XCTAssertEqual(vendingMachine.coinsInCoinReturn, [])
    }

    func testAcceptMultipleCoins() {
        vendingMachine.addCoin(.Nickel)
        vendingMachine.addCoin(.Dime)
        vendingMachine.addCoin(.Quarter)
        vendingMachine.addCoin(.Unknown)

        XCTAssertEqual(vendingMachine.display, "$0.40")
        XCTAssertEqual(vendingMachine.coinsInCoinReturn, [.Unknown])
    }

    func testAcceptCoinMessage() {
        vendingMachine.addCoin(.Nickel)
        vendingMachine.selectProductWithName("cola")
        vendingMachine.addCoin(.Quarter)

        XCTAssertEqual(vendingMachine.display, "$0.30")
    }

}
