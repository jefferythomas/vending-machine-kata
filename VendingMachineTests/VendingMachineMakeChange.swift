//
//  VendingMachineMakeChange.swift
//  VendingMachine
//
//  Created by Jeffery Thomas on 8/26/15.
//  Copyright © 2015 JLT Source. All rights reserved.
//

import XCTest
@testable import VendingMachine

class VendingMachineMakeChange: XCTestCase {

    var vendingMachine = VendingMachine()

    override func setUp() {
        super.setUp()
        vendingMachine = VendingMachine()
    }

    func testMakeChangeForCandyPaidWith3Quarters() {
        vendingMachine.addCoin(.Quarter)
        vendingMachine.addCoin(.Quarter)
        vendingMachine.addCoin(.Quarter)

        vendingMachine.selectProductWithName("candy")

        XCTAssertEqual(vendingMachine.display, "THANK YOU")
        XCTAssertEqual(vendingMachine.display, "INSERT COIN")
        XCTAssertEqual(vendingMachine.coinReturnValue, "$0.10")
        XCTAssertEqual(vendingMachine.coinReturnCount, 1)
    }

}
