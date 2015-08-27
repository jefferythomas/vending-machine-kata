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
        } else if totalValue == NSDecimalNumber.zero() {
            return "INSERT COIN"
        } else {
            return stringFromValue(totalValue)
        }
    }

    public var coinReturnCount: Int {
        return coinsInReturn.count
    }

    public var coinReturnValue: String {
        return stringFromValue(coinsInReturn.reduce(NSDecimalNumber.zero()) {
            $0 + (coinValueForCoin($1) ?? NSDecimalNumber.zero())
        })
    }

    public func addCoin(coin: Coin) {
        if let coinValue = coinValueForCoin(coin) {
            totalValue = totalValue + coinValue
        } else {
            coinsInReturn.append(coin)
        }
    }

    public func selectProductWithName(name: String) {
        coinsInReturn = []

        guard let productPrice = products[name] else {
            return
        }

        if totalValue.isLessThan(productPrice) {
            messageToDisplay = "PRICE \(stringFromValue(productPrice))"
        } else {
            messageToDisplay = "THANK YOU"
            coinsInReturn = coinsForValue(totalValue - productPrice)
            totalValue = NSDecimalNumber.zero()
        }
    }

    // MARK: Memory lifecycle

    public init() { }

    // MARK: Private

    private func coinsForValue(value: NSDecimalNumber) -> [Coin] {
        var result = [Coin]()
        var currentValue = NSDecimalNumber.zero()

        while currentValue + valueForQuarter <= value {
            result.append(.Quarter)
            currentValue = currentValue + valueForQuarter

            if currentValue == value {
                return result
            }
        }

        while currentValue + valueForDime <= value {
            result.append(.Dime)
            currentValue = currentValue + valueForDime

            if currentValue == value {
                return result
            }
        }

        while currentValue + valueForNickel <= value {
            result.append(.Nickel)
            currentValue = currentValue + valueForNickel

            if currentValue == value {
                return result
            }
        }

        assert(currentValue == value)
        return result
    }

    private func coinValueForCoin(coin: Coin) -> NSDecimalNumber? {
        switch coin {
        case .Nickel: return valueForNickel
        case .Dime: return valueForDime
        case .Quarter: return valueForQuarter
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

    let valueForNickel = NSDecimalNumber(string: "0.05")
    let valueForDime = NSDecimalNumber(string: "0.10")
    let valueForQuarter = NSDecimalNumber(string: "0.25")

    private var totalValue = NSDecimalNumber.zero()
    private var messageToDisplay: String?
    private var coinsInReturn = [Coin]()

}
