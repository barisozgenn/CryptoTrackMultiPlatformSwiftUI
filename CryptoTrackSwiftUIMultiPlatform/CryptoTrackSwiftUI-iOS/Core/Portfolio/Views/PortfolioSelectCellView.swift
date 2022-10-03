//
//  PortfolioSelectCellView.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 24.09.2022.
//

import SwiftUI

struct PortfolioSelectCellView: View {
    let cryptoCurrency : CryptoCurrency
    init(cryptoCurrency: CryptoCurrency) {
        self.cryptoCurrency = cryptoCurrency
    }
    var body: some View {
        VStack(spacing: 4){
            // image
            CurrencyImageView(cryptoCurrency: cryptoCurrency)
                .scaledToFit()
                .frame(width: 64, height: 64)
                .padding(.leading, 4)
            
            // name & symbol
            Text(cryptoCurrency.symbol.uppercased())
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color.theme.primaryTextColor)
            
            Text(cryptoCurrency.name)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
                .frame(width: 100)
        }
        .padding(.all, 10)
        .background(.gray.opacity(0.1))
        .cornerRadius(4)
        
    }
}

struct PortfolioSelectCellView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioSelectCellView(cryptoCurrency: dev.cryptoCurrency)
    }
}
