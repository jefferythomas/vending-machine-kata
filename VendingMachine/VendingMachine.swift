//
//  VendingMachine.swift
//  vending-machine-kata
//
//  Created by Jeffery Thomas on 8/25/15.
//  Copyright © 2015 JLT Source. All rights reserved.
//

import Foundation

public class VendingMachine {

    public enum Coin {
        case Unknown
        case Nickel
        case Dime
        case Quarter
    }

    let products = ["cola" : NSDecimalNumber(string: "1.00")]

    public var display: String {
        if hasSelectedProduct {
            hasSelectedProduct = false
            return "THANK YOU"
        } else if totalValue == NSDecimalNumber(string: "0.00") {
            return "INSERT COIN"
        } else {
            let formatter = NSNumberFormatter()
            formatter.numberStyle = .CurrencyStyle
            return formatter.stringFromNumber(totalValue)!
        }
    }

    public private(set) var coinReturnCount = 0

    public func addCoin(coin: Coin) {
        if let coinValue = coinValueForCoin(coin) {
            totalValue = totalValue.decimalNumberByAdding(coinValue)
        } else {
            ++coinReturnCount
        }
    }

    public func selectProductWithName(name: String) {
        guard let productCost = products[name] else {
            return
        }

        if totalValue.isGreaterThanOrEqualTo(productCost) {
            hasSelectedProduct = true
            totalValue = NSDecimalNumber(string: "0.00")
        }
    }

    public init() { }

    private func coinValueForCoin(coin: Coin) -> NSDecimalNumber? {
        switch coin {
        case .Nickel: return NSDecimalNumber(string: "0.05")
        case .Dime: return NSDecimalNumber(string: "0.10")
        case .Quarter: return NSDecimalNumber(string: "0.25")
        default: return nil
        }
    }

    private var totalValue = NSDecimalNumber(string: "0.00")
    private var hasSelectedProduct = false

}
