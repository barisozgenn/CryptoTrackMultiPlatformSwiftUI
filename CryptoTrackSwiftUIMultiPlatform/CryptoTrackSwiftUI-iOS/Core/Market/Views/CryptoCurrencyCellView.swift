//
//  CryptoCurrencyCellView.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 18.09.2022.
//

import SwiftUI

struct CryptoCurrencyCellView:View {
    
    let cryptoCurrency : CryptoCurrency
    
    var body: some View {
        HStack{
            // market rank & image
            HStack{
                // market rank
                Text("\(cryptoCurrency.marketCapRank)")
                    .font(.system(size: 10))
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                    .frame(width: 20, alignment: .trailing)
                
                
                // image
                CurrencyImageView(cryptoCurrency: cryptoCurrency)
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .padding(.leading, -4)
                
            }
            .frame(alignment: .leading)
            
            // name & symbol
            VStack(alignment: .leading,spacing:0){
                Text(cryptoCurrency.name)
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.theme.primaryTextColor)
                    .frame(alignment: .leading)
                
                Text(cryptoCurrency.symbol.uppercased())
                    .font(.caption)
                    .foregroundColor(.gray)
                    .frame(alignment: .leading)
                
            }
            .frame(width: 120, alignment: .leading)
            
            Spacer()
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: 50)
            
            // last price
            VStack(alignment: .trailing, spacing: 1){
                Text(cryptoCurrency.currentPrice.toUSDCurrencyFormatted())
                    .font(.system(size:
                                    cryptoCurrency.currentPrice > 0.0001 ? 14 : 12)  )
                    .fontWeight(.semibold)
                    .foregroundColor(cryptoCurrency.priceChangePercentage24H.toPercentColor())
                
                Text(cryptoCurrency.currentPrice.toUSDCurrency())
                    .font(.system(size:
                                    cryptoCurrency.currentPrice > 0.0001 ? 12 : 10)  )
                    .foregroundColor(.gray)
            }
            .frame(width: 100,alignment: .trailing)
            .padding(.horizontal,0)
            
            // 24h Change
            VStack{
                Text(cryptoCurrency.priceChangePercentage24H.toPercentString())
                    .font(.system(size: 11))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .frame(width: 55)
            .padding(.vertical, 11)
            .padding(.horizontal,3)
            .background(cryptoCurrency.priceChangePercentage24H.toPercentColor())
            .cornerRadius(4)
            
        }
        .background(Color.theme.itemBackgroundColor)
        .padding(.horizontal,4)
    }
}

struct CryptoCurrencyCellView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoCurrencyCellView(cryptoCurrency: dev.cryptoCurrency)
    }
}
