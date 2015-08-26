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

    public var display: String {
        if let message = messageToDisplay {
            messageToDisplay = nil
            return message
        } else if totalValue == NSDecimalNumber(string: "0.00") {
            return "INSERT COIN"
        } else {
            return stringFromValue(totalValue)
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
        guard let productPrice = products[name] else {
            return
        }

        if totalValue.isLessThan(productPrice) {
            messageToDisplay = "PRICE \(stringFromValue(productPrice))"
        } else {
            messageToDisplay = "THANK YOU"
            totalValue = NSDecimalNumber(string: "0.00")
        }
    }

    // MARK: Memory lifecycle

    public init() { }

    // MARK: Private

    private func coinValueForCoin(coin: Coin) -> NSDecimalNumber? {
        switch coin {
        case .Nickel: return NSDecimalNumber(string: "0.05")
        case .Dime: return NSDecimalNumber(string: "0.10")
        case .Quarter: return NSDecimalNumber(string: "0.25")
        default: return nil
        }
    }

    private func stringFromValue(value: NSDecimalNumber) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        return formatter.stringFromNumber(value)!
    }

    private let products = [
        "cola" : NSDecimalNumber(string: "1.00"),
        "chips" : NSDecimalNumber(string: "0.50"),
        "candy" : NSDecimalNumber(string: "0.65"),
    ]

    private var totalValue = NSDecimalNumber(string: "0.00")
    private var messageToDisplay: String?

}
