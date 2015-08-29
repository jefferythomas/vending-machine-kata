//
//  VendingMachineMakeChange.swift
//  VendingMachine
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
        XCTAssertEqual(vendingMachine.coinsInCoinReturn, [.Dime])
    }

    func testMakeChangeForCandyPaidWith5Quarters() {
        vendingMachine.addCoin(.Quarter)
        vendingMachine.addCoin(.Quarter)
        vendingMachine.addCoin(.Quarter)
        vendingMachine.addCoin(.Quarter)
        vendingMachine.addCoin(.Quarter)

        vendingMachine.selectProductWithName("candy")

        XCTAssertEqual(vendingMachine.display, "THANK YOU")
        XCTAssertEqual(vendingMachine.display, "INSERT COIN")
        XCTAssertEqual(vendingMachine.coinsInCoinReturn, [.Quarter, .Quarter, .Dime])
    }

    func testMakeChangeForCandyPaidWith3QuartersAnd1Nickel() {
        vendingMachine.addCoin(.Quarter)
        vendingMachine.addCoin(.Quarter)
        vendingMachine.addCoin(.Quarter)
        vendingMachine.addCoin(.Nickel)

        vendingMachine.selectProductWithName("candy")

        XCTAssertEqual(vendingMachine.display, "THANK YOU")
        XCTAssertEqual(vendingMachine.display, "INSERT COIN")
        XCTAssertEqual(vendingMachine.coinsInCoinReturn, [.Dime, .Nickel])
    }

}
