//
//  CryptoCurrencyHorizontalListView.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 18.09.2022.
//

import SwiftUI

struct CryptoCurrencyHorizontalListView:  View {
    @StateObject var viewModel : MarketViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing:8){
                    HStack(spacing: 0){
                        Text("TOP")
                            .rotationEffect(.degrees(-90))
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .font(.caption)
                        Text("5")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .padding(.trailing, 4)
                            .padding(.leading,-5)
                    }
                    .frame(height: 75)
                        .background(Color.theme.itemBackgroundColor)
                        .overlay(
                            RoundedRectangle(cornerRadius:14)
                                .stroke(Color(.systemGray5), lineWidth: 2)
                        )
                    ForEach(viewModel.topCryptoCurrencies){cryptoCurrency in
                        NavigationLink{
                            LayzNavigationView(build: CoinDetailView(cryptoCurrency: cryptoCurrency))
                            
                        }
                    label:{
                        CryptoCurrencyHorizontalCellView(cryptoCurrency: cryptoCurrency)
                    }
                        
                    }
                }
            }
        }.padding()
    }
}

struct CryptoCurrencyHorizontalListView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoCurrencyHorizontalListView(viewModel: MarketViewModel())
    }
}
