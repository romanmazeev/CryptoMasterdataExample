//
//  Double+Currency.swift
//  BitpandaTest
//
//  Created by Roman Mazeev on 09/03/22.
//

import Foundation

extension Double {
    func toCurrencyString(maximumFractionDigits: Int, symbolCharacter: String) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        currencyFormatter.currencySymbol = symbolCharacter
        currencyFormatter.maximumFractionDigits = maximumFractionDigits
        return currencyFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
