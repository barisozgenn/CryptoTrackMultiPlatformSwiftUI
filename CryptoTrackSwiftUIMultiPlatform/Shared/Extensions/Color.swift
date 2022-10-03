//
//  Color.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 15.09.2022.
//

import SwiftUI

extension Color{
    static let theme = ColorTheme()
}

struct ColorTheme{
    let primaryTextColor = Color("PrimaryTextColor")
    let itemBackgroundColor = Color("ItemBackgroundColor")
    let appBackgroundColor = Color("AppBackgroundColor")
    let currencyGreenColor = Color("CurrencyGreenColor")
    let currencyRedColor = Color("CurrencyRedColor")
    
    func getChartGraphicLineColor(firstValue:Double, lastValue:Double) -> Color {
        return lastValue >= firstValue ? Color.theme.currencyGreenColor : Color.theme.currencyRedColor
    }

}


