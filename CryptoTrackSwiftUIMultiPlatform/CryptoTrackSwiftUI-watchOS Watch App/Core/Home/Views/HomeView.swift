//
//  HomeView.swift
//  CryptoTrackSwiftUI-watchOS Watch App
//
//  Created by Baris OZGEN on 5.10.2022.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var viewModel : HomeViewModel
    
    var body: some View {
        
        ZStack{
            // table list
            ScrollView(showsIndicators: false){
                LazyVStack(spacing: 14){
                    // search bar
                    SearchBarView(searchText: $viewModel.searchText)
                    
                    ForEach(viewModel.cryptoCurrencies){cryptoCurrency in
                        
                        NavigationLink{
                            
                            
                        }
                    label:{
                        
                        // currency cell view
                        VStack{
                            HStack{
                                VStack(alignment: .leading){
                                    Text(cryptoCurrency.symbol.uppercased())
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    
                                    Text(cryptoCurrency.name)
                                        .font(.caption2)
                                        .foregroundColor(.white)
                                }
                                
                                
                                Spacer()
                                
                                // price
                                VStack(alignment: .trailing){
                                    Text(cryptoCurrency.currentPrice.toUSDCurrency())
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    
                                    Text((cryptoCurrency.priceChangePercentage24H ?? 0 ).toPercentString())
                                        .font(.caption)
                                        .fontWeight(.black)
                                        .foregroundColor((cryptoCurrency.priceChangePercentage24H ?? 0) < 0 ? .red : .green )
                                }
                                
                            }
                        }
                      
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
    }
}
