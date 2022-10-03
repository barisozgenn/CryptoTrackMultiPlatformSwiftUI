//
//  Double.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 14.09.2022.
//

import Foundation
import SwiftUI

extension Double {
    
    private var currencyPriceFormatter : NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.currencySymbol = "$"
        return formatter
    }
    private var percentageFormatter : NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }
    
    func toUSDCurrency() -> String {
        
        let price = abs(Double(self))
        var priceString = ""
        if price > 1.0 {
            priceString = currencyPriceFormatter.string(for: price) ?? "$0.00"
        }
        else {
            var digit = 2
            
            if price > 0.1 { digit = 3}
            else if price > 0.01 { digit = 3}
            else if price > 0.001 { digit = 4}
            else if price > 0.0001 { digit = 5}
            else if price > 0.00001 { digit = 6}
            else {digit = 10}
            
            priceString = "$" + price.asNumberString(digit: digit)
        }
        return priceString
    }
    func toUSDCurrencyFormatted() -> String {
        var priceString =  self.toUSDCurrency()
        
        while (priceString.last == "0"){
          priceString = String(priceString.dropLast())
        }
        if priceString.last == "." || priceString.last == "," {priceString =  String(priceString.dropLast())}
        
        return priceString
    }
    
    func toPercentString() -> String {
        return "\(self >= 0 ? "+":"-" )%"+(percentageFormatter.string(for: self) ?? "0.00").replacingOccurrences(of: "-", with: "")
    }
    
    func asNumberString(digit: Int = 2) -> String{
        return String(format: "%.\(digit)f", self)
    }
    
    func toPercentColor() -> Color {
        return self >= 0 ? Color.theme.currencyGreenColor : Color.theme.currencyRedColor
    }
    func getImageArrowSystemName() -> String{
        return self >= 0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill"
    }
    func formattedWithAbbreviations() -> String {
        let number = abs(Double(self))
        let sign = (self < 0) ? "-" : ""
        
        switch number {
            
        case 1_000_000_000_000...:
            let formatted = number / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = number / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = number / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = number / 1_000
            let stringFormatted = formatted.asNumberString(digit: 3)
            return "\(sign)\(stringFormatted)K"
        case 1...:
            return self.asNumberString(digit: 3)
        case 0...:
            return self.asNumberString(digit: 6)
            
        default:
            return "\(sign)\(self)"
        }
    }
}
