//
//  VendingMachine.swift
//  vending-machine-kata
//
//  Created by Jeffery Thomas on 8/25/15.
//  Copyright © 2015 JLT Source. All rights reserved.
//

import Foundation

public enum Coin {
    case Unknown
    case Nickel
    case Dime
    case Quarter
}

private let zeroAmount = NSDecimalNumber.zero()
private let nickelAmount = NSDecimalNumber(string: "0.05")
private let dimeAmount = NSDecimalNumber(string: "0.10")
private let quarterAmount = NSDecimalNumber(string: "0.25")

public class VendingMachine {

    public var display: String {
        if let message = messageForNextDisplay {
            messageForNextDisplay = nil
            return message
        } else if totalAmount == zeroAmount {
            return "INSERT COIN"
        } else {
            return stringFromAmount(totalAmount)
        }
    }

    public private(set) var coinsInCoinReturn = [Coin]()

    public func addCoin(coin: Coin) {
        if let amount = amountForCoin(coin) {
            totalAmount = totalAmount + amount
        } else {
            coinsInCoinReturn.append(coin)
        }
    }

    public func selectProductWithName(name: String) {
        coinsInCoinReturn = []

        guard let productPrice = products[name] else {
            assert(false, "\(name) is not a valid product name")
            return
        }

        if totalAmount < productPrice {
            messageForNextDisplay = "PRICE \(stringFromAmount(productPrice))"
        } else {
            messageForNextDisplay = "THANK YOU"
            coinsInCoinReturn = coinsForAmount(totalAmount - productPrice)
            totalAmount = zeroAmount
        }
    }

    // MARK: Memory lifecycle

    public init() { } // NOTE: a do nothing init() to make init() public

    // MARK: Private

    private func amountForCoins(coins: [Coin]) -> NSDecimalNumber {
        return coins.reduce(zeroAmount) { total, coin in total + (amountForCoin(coin) ?? zeroAmount) }
    }

    private func coinsForAmount(amount: NSDecimalNumber) -> [Coin] {
        var coins = [Coin]()
        var currentAmount = zeroAmount

        while currentAmount + quarterAmount <= amount {
            coins.append(.Quarter)
            currentAmount = currentAmount + quarterAmount

            if currentAmount == amount {
                break
            }
        }

        while currentAmount + dimeAmount <= amount {
            coins.append(.Dime)
            currentAmount = currentAmount + dimeAmount

            if currentAmount == amount {
                break
            }
        }

        while currentAmount + nickelAmount <= amount {
            coins.append(.Nickel)
            currentAmount = currentAmount + nickelAmount

            if currentAmount == amount {
                break
            }
        }

        assert(currentAmount == amount, "could not return exact change for \(amount)")
        return coins
    }

    private func amountForCoin(coin: Coin) -> NSDecimalNumber? {
        switch coin {
        case .Nickel: return nickelAmount
        case .Dime: return dimeAmount
        case .Quarter: return quarterAmount
        default: return nil
        }
    }

    private func stringFromAmount(amount: NSDecimalNumber) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        return formatter.stringFromNumber(amount)!
    }

    private let products = [
        "cola" : NSDecimalNumber(string: "1.00"),
        "chips" : NSDecimalNumber(string: "0.50"),
        "candy" : NSDecimalNumber(string: "0.65"),
    ]

    private var totalAmount = zeroAmount
    private var messageForNextDisplay: String? = nil

}
