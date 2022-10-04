//
//  CryptoCurrencyListView.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 18.09.2022.
//

import SwiftUI

struct CryptoCurrencyListView: View {
    @StateObject var viewModel : MarketViewModel
    
    var body: some View {
        VStack(){
            
            // search bar
            SearchBarView(searchText: $viewModel.searchText)
            
            // table titles
            CurrenciesTableTitleView(viewModel: viewModel)
#if os(tvOS)
                .focusable(true)
#endif
            // table list
            ScrollView{
                LazyVStack(spacing: 2){
                    
                    ForEach(viewModel.cryptoCurrencies){cryptoCurrency in
                        CryptoCurrencyCellView(cryptoCurrency: cryptoCurrency)
#if os(macOS)
                            .frame(minHeight: 50)
#elseif os(tvOS)
                            .frame(minHeight: 100)
#endif
                    }
                }
                
            }
#if os(macOS)
                            .frame(minHeight: 329)
#elseif os(tvOS)
                            .frame(minHeight: 792)
#endif
            .refreshable {
                viewModel.refreshData()
            }
        }
    }
}

struct CryptoCurrencyListView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoCurrencyListView(viewModel: MarketViewModel())
    }
}
