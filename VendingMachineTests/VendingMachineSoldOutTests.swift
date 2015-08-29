//
//  VendingMachineSoldOutTests.swift
//  VendingMachine
//
//  Created by Jeffery Thomas on 8/29/15.
//  Copyright © 2015 Jeffery Thomas. All rights reserved.
//

import XCTest
@testable import VendingMachine

class VendingMachineSoldOutTests: XCTestCase {

    func testSoldOut() {
        let vendingMachine = VendingMachine(stock: [:])

        vendingMachine.addCoin(.Quarter)
        vendingMachine.addCoin(.Quarter)
        vendingMachine.addCoin(.Quarter)
        vendingMachine.addCoin(.Quarter)

        vendingMachine.selectProductWithName("cola")

        XCTAssertEqual(vendingMachine.display, "SOLD OUT")
        XCTAssertEqual(vendingMachine.display, "$1.00")
    }

    func testSell1ThenSoldOut() {
        let vendingMachine = VendingMachine(stock: ["cola" : 1])

        vendingMachine.addCoin(.Quarter)
        vendingMachine.addCoin(.Quarter)
        vendingMachine.addCoin(.Quarter)
        vendingMachine.addCoin(.Quarter)

        vendingMachine.selectProductWithName("cola")

        XCTAssertEqual(vendingMachine.display, "THANK YOU")

        vendingMachine.addCoin(.Quarter)
        vendingMachine.addCoin(.Quarter)
        vendingMachine.addCoin(.Quarter)
        vendingMachine.addCoin(.Quarter)

        vendingMachine.selectProductWithName("cola")

        XCTAssertEqual(vendingMachine.display, "SOLD OUT")
    }

}
