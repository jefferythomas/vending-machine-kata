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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAcceptNickel() {
        let vendingMachine = VendingMachine()

        vendingMachine.addCoin(.Nickel)
        XCTAssertEqual(vendingMachine.display, "$0.05")
        XCTAssertEqual(vendingMachine.coinReturnCount, 0)
    }

}
