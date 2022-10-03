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
            ScrollView(showsIndicators: false){
                LazyVStack(spacing: 14){
                    
                    ForEach(viewModel.cryptoCurrencies){cryptoCurrency in
                        
                        NavigationLink{
                            LayzNavigationView(build: CoinDetailView(cryptoCurrency: cryptoCurrency))
                            
                        }
                    label:{
                        
                        CryptoCurrencyCellView(cryptoCurrency: cryptoCurrency)
                        
                      
                    }
                        
                    }
                }
            }
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
