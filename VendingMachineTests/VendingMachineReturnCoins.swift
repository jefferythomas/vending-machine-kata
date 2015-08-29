//
//  VendingMachineReturnCoins.swift
//  VendingMachine
//
//  Created by Jeffery Thomas on 8/28/15.
//  Copyright © 2015 JLT Source. All rights reserved.
//

import XCTest
@testable import VendingMachine

class VendingMachineReturnCoins: XCTestCase {

    var vendingMachine = VendingMachine()

    override func setUp() {
        super.setUp()
        vendingMachine = VendingMachine()
    }

    func testReturnCoins() {
        vendingMachine.addCoin(.Quarter)

        vendingMachine.returnCoins()

        XCTAssertEqual(vendingMachine.display, "INSERT COIN")
        XCTAssertEqual(vendingMachine.coinsInCoinReturn, [.Quarter])
    }

    func testReturnedCoinsEqualsInsertedCoins() {
        vendingMachine.addCoin(.Nickel)
        vendingMachine.addCoin(.Nickel)
        vendingMachine.addCoin(.Dime)

        vendingMachine.returnCoins()

        XCTAssertEqual(vendingMachine.display, "INSERT COIN")
        XCTAssertEqual(vendingMachine.coinsInCoinReturn, [.Nickel, .Nickel, .Dime])
    }

    func testReturnCoinsInsertCoinMessage() {
        vendingMachine.addCoin(.Nickel)

        vendingMachine.selectProductWithName("cola")
        vendingMachine.returnCoins()

        XCTAssertEqual(vendingMachine.display, "INSERT COIN")
    }

}
