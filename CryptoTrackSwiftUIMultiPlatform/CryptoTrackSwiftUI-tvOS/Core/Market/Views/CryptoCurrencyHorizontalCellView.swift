//
//  CryptoCurrencyHorizontalCellView.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 18.09.2022.
//

import SwiftUI

struct CryptoCurrencyHorizontalCellView: View {
    let cryptoCurrency : CryptoCurrency
    
    var body: some View {
        NavigationLink(destination:
                        LayzNavigationView(build: CoinDetailView(cryptoCurrency: cryptoCurrency))
        )
        {
            HStack(spacing: 2){
                // image
                CurrencyImageView(cryptoCurrency: cryptoCurrency)
                    .frame(width: 32, height: 32)
                    .foregroundColor(.orange)
                    .padding(.bottom,6)
                
                VStack{
                    // coin info
                    HStack(spacing : 2){
                        Text(cryptoCurrency.symbol.uppercased())
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(Color.theme.primaryTextColor)
                        
                        Text(cryptoCurrency.currentPrice.toUSDCurrency())
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    
                    // coin percent change
                    Text((cryptoCurrency.priceChangePercentage24H ?? 0).toPercentString())
                        .font(.title2)
                        .foregroundColor((cryptoCurrency.priceChangePercentage24H ?? 0 ).toPercentColor())
                }
                
            }
            .frame(width: 150, height: 75)
            .background(Color.theme.itemBackgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius:14)
                    .stroke(Color(.black), lineWidth: 2)
            )
            .padding(.horizontal,8)
            .frame(width: 150, height: 75)
            .cornerRadius(14)
        }
#if os(macOS)
        .buttonStyle(.borderless)
#elseif os(tvOS)
        .buttonStyle(.card)
#endif
        
    }
}
struct CryptoCurrencyHorizontalCellView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoCurrencyHorizontalCellView(cryptoCurrency: dev.cryptoCurrency)
    }
}
