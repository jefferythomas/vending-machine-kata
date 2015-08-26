//
//  VendingMachineTests.swift
//  VendingMachineTests
//
//  Created by Jeffery Thomas on 8/26/15.
//  Copyright © 2015 JLT Source. All rights reserved.
//

import XCTest
@testable import VendingMachine

class VendingMachineTests: XCTestCase {

    var vendingMachine = VendingMachine()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        vendingMachine = VendingMachine()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testNoCoinsInVendingMachine() {
        XCTAssertEqual(vendingMachine.display, "INSERT COIN")
        XCTAssertEqual(vendingMachine.coinReturnCount, 0)
    }

    func testReturnUnknownCoin() {
        vendingMachine.addCoin(.Unknown)
        XCTAssertEqual(vendingMachine.display, "INSERT COIN")
        XCTAssertEqual(vendingMachine.coinReturnCount, 1)
    }

    func testAcceptNickel() {
        vendingMachine.addCoin(.Nickel)
        XCTAssertEqual(vendingMachine.display, "$0.05")
        XCTAssertEqual(vendingMachine.coinReturnCount, 0)
    }

    func testAcceptDime() {
        vendingMachine.addCoin(.Dime)
        XCTAssertEqual(vendingMachine.display, "$0.10")
        XCTAssertEqual(vendingMachine.coinReturnCount, 0)
    }

    func testAcceptQuarter() {
        vendingMachine.addCoin(.Quarter)
        XCTAssertEqual(vendingMachine.display, "$0.25")
        XCTAssertEqual(vendingMachine.coinReturnCount, 0)
    }

}
