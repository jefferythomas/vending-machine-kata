//
//  VendingMachineSelectProductTests.swift
//  VendingMachine
//
//  Created by Jeffery Thomas on 8/26/15.
//  Copyright © 2015 JLT Source. All rights reserved.
//

import XCTest
@testable import VendingMachine

class VendingMachineSelectProductTests: XCTestCase {

    var vendingMachine = VendingMachine()

    override func setUp() {
        super.setUp()
        vendingMachine = VendingMachine()
    }

    func testSelectColaWithNoMoney() {
        vendingMachine.selectProductWithName("cola")

        XCTAssertEqual(vendingMachine.display, "PRICE $1.00")
        XCTAssertEqual(vendingMachine.display, "INSERT COIN")
        XCTAssertEqual(vendingMachine.coinReturnCount, 0)
    }

    func testSelectColaWithNotEnoughMoney() {
        vendingMachine.addCoin(.Quarter)

        vendingMachine.selectProductWithName("cola")

        XCTAssertEqual(vendingMachine.display, "PRICE $1.00")
        XCTAssertEqual(vendingMachine.display, "$0.25")
        XCTAssertEqual(vendingMachine.coinReturnCount, 0)
    }

    func testSelectCola() {
        vendingMachine.addCoin(.Quarter)
        vendingMachine.addCoin(.Quarter)
        vendingMachine.addCoin(.Quarter)
        vendingMachine.addCoin(.Quarter)

        vendingMachine.selectProductWithName("cola")

        XCTAssertEqual(vendingMachine.display, "THANK YOU")
        XCTAssertEqual(vendingMachine.display, "INSERT COIN")
        XCTAssertEqual(vendingMachine.coinReturnCount, 0)
    }

    func testSelectChips() {
        vendingMachine.addCoin(.Quarter)
        vendingMachine.addCoin(.Quarter)

        vendingMachine.selectProductWithName("chips")

        XCTAssertEqual(vendingMachine.display, "THANK YOU")
        XCTAssertEqual(vendingMachine.display, "INSERT COIN")
        XCTAssertEqual(vendingMachine.coinReturnCount, 0)
    }

}
