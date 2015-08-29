//
//  VendingMachine.swift
//  vending-machine-kata
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
        }

        if coinsInMachine.count == 0 {
            return "INSERT COIN"
        }

        return stringFromAmount(amountForCoins(coinsInMachine))
    }

    public private(set) var coinsInCoinReturn = [Coin]()

    public func addCoin(coin: Coin) {
        if coin == .Unknown { // Reject the unknown coin by putting it in the coin return.
            coinsInCoinReturn.append(coin)
            return
        }

        messageForNextDisplay = nil
        coinsInMachine.append(coin)
    }

    public func selectProductWithName(name: String) {
        coinsInCoinReturn = [] // Assume the coin return was cleared before selecting a product

        let insertedAmount = amountForCoins(coinsInMachine)

        guard let price = prices[name] else {
            assert(false, "\(name) is not a valid product name")
            return
        }

        guard let remainingStock = stock[name] where remainingStock > 0 else {
            messageForNextDisplay = "SOLD OUT"
            return
        }

        if insertedAmount < price {
            messageForNextDisplay = "PRICE \(stringFromAmount(price))"
            return
        }

        messageForNextDisplay = "THANK YOU"
        coinsInCoinReturn = coinsForAmount(insertedAmount - price)
        coinsInMachine = []
    }

    public func returnCoins() {
        messageForNextDisplay = nil
        coinsInCoinReturn = coinsInMachine
        coinsInMachine = []
    }

    // MARK: Memory lifecycle

    public init() {
        prices = [
            "cola" : NSDecimalNumber(string: "1.00"),
            "chips" : NSDecimalNumber(string: "0.50"),
            "candy" : NSDecimalNumber(string: "0.65"),
        ]

        stock = [
            "cola" : 10,
            "chips" : 10,
            "candy" : 10,
        ]
    }

    public init(stock: [String : Int]) {
        prices = [
            "cola" : NSDecimalNumber(string: "1.00"),
            "chips" : NSDecimalNumber(string: "0.50"),
            "candy" : NSDecimalNumber(string: "0.65"),
        ]

        self.stock = stock
    }

    // MARK: Private

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

    private func amountForCoins(coins: [Coin]) -> NSDecimalNumber {
        return coins.reduce(zeroAmount) { total, coin in total + (amountForCoin(coin) ?? zeroAmount) }
    }

    private func stringFromAmount(amount: NSDecimalNumber) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        return formatter.stringFromNumber(amount)!
    }

    private let prices: [String : NSDecimalNumber]
    private var stock: [String : Int]
    private var coinsInMachine = [Coin]()
    private var messageForNextDisplay: String? = nil

}
