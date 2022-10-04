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
            
            // table list
            ScrollView{
                LazyVStack(spacing: 2){
                    
                    ForEach(viewModel.cryptoCurrencies){cryptoCurrency in
                        CryptoCurrencyCellView(cryptoCurrency: cryptoCurrency)
                            .frame(height: 50)
                    }
                }
                
            }
            .frame(height: 329)
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
