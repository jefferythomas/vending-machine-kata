//
//  VendingMachineSelectProductTests.swift
//  VendingMachine
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
        XCTAssertEqual(vendingMachine.coinsInCoinReturn, [])
    }

    func testSelectColaWithNotEnoughMoney() {
        vendingMachine.addCoin(.Quarter)

        vendingMachine.selectProductWithName("cola")

        XCTAssertEqual(vendingMachine.display, "PRICE $1.00")
        XCTAssertEqual(vendingMachine.display, "$0.25")
        XCTAssertEqual(vendingMachine.coinsInCoinReturn, [])
    }

    func testSelectCola() {
        vendingMachine.addCoin(.Quarter)
        vendingMachine.addCoin(.Quarter)
        vendingMachine.addCoin(.Quarter)
        vendingMachine.addCoin(.Quarter)

        vendingMachine.selectProductWithName("cola")

        XCTAssertEqual(vendingMachine.display, "THANK YOU")
        XCTAssertEqual(vendingMachine.display, "INSERT COIN")
        XCTAssertEqual(vendingMachine.coinsInCoinReturn, [])
    }

    func testSelectChips() {
        vendingMachine.addCoin(.Quarter)
        vendingMachine.addCoin(.Quarter)

        vendingMachine.selectProductWithName("chips")

        XCTAssertEqual(vendingMachine.display, "THANK YOU")
        XCTAssertEqual(vendingMachine.display, "INSERT COIN")
        XCTAssertEqual(vendingMachine.coinsInCoinReturn, [])
    }

    func testSelectCandy() {
        vendingMachine.addCoin(.Nickel)
        vendingMachine.addCoin(.Dime)
        vendingMachine.addCoin(.Quarter)
        vendingMachine.addCoin(.Quarter)

        vendingMachine.selectProductWithName("candy")

        XCTAssertEqual(vendingMachine.display, "THANK YOU")
        XCTAssertEqual(vendingMachine.display, "INSERT COIN")
        XCTAssertEqual(vendingMachine.coinsInCoinReturn, [])
    }

}
