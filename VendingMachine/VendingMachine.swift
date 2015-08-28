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
        guard let amount = amountForCoin(coin) else {
            // Reject the coin by putting it in the coin return.
            coinsInCoinReturn.append(coin)
            return
        }

        totalAmount = totalAmount + amount
    }

    public func selectProductWithName(name: String) {
        coinsInCoinReturn = [] // Assume the coin return was cleared before selecting a product

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

    public func returnCoins() {
        coinsInCoinReturn = coinsForAmount(totalAmount)
        totalAmount = zeroAmount
    }

    // MARK: Memory lifecycle

    public init() { } // NOTE: a do nothing init() to make init() public

    // MARK: Private

    private func amountForCoins(coins: [Coin]) -> NSDecimalNumber {
        return coins.reduce(zeroAmount) { total, coin in total + (amountForCoin(coin) ?? zeroAmount) }
    }

    private func coinsForAmount(amount: NSDecimalNumber) -> [Coin] {
        var remainingAmount = amount

        let numberOfQuarters = numberOfCoinsInAmount(remainingAmount, forCoin: .Quarter)
        remainingAmount = remainingAmount - amountForCoin(.Quarter, count: numberOfQuarters)!

        let numberOfDimes = numberOfCoinsInAmount(remainingAmount, forCoin: .Dime)
        remainingAmount = remainingAmount - amountForCoin(.Dime, count: numberOfDimes)!

        let numberOfNickels = numberOfCoinsInAmount(remainingAmount, forCoin: .Nickel)
        remainingAmount = remainingAmount - amountForCoin(.Nickel, count: numberOfNickels)!

        assert(remainingAmount == zeroAmount, "could not return exact change for \(amount)")

        return (
            [Coin](count: numberOfQuarters, repeatedValue: .Quarter) +
            [Coin](count: numberOfDimes, repeatedValue: .Dime) +
            [Coin](count: numberOfNickels, repeatedValue: .Nickel)
        )
    }

    private func numberOfCoinsInAmount(amount: NSDecimalNumber, forCoin coin: Coin) -> Int {
        return (amount / amountForCoin(coin)!).integerValue
    }

    private func amountForCoin(coin: Coin) -> NSDecimalNumber? {
        switch coin {
        case .Nickel: return NSDecimalNumber(string: "0.05")
        case .Dime: return NSDecimalNumber(string: "0.10")
        case .Quarter: return NSDecimalNumber(string: "0.25")
        default: return nil
        }
    }

    private func amountForCoin(coin: Coin, count: Int) -> NSDecimalNumber? {
        guard let coinAmount = amountForCoin(coin) else {
            return nil
        }

        return NSDecimalNumber(integer: count) * coinAmount
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
