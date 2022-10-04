//
//  MarketView.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 18.09.2022.
//

import SwiftUI

struct MarketView: View {
        
    @EnvironmentObject private var viewModel : MarketViewModel

    var body: some View {
            NavigationStack{
                ZStack{
                    VStack{
                        
                        VStack{
                            // arrow and indicator
                            Image(systemName: "arrow.down")
                                .font(.headline)
                                .foregroundColor(.orange)
                                .offset(y: -170)
                            
                            // top movers view
                            CryptoCurrencyHorizontalListView(viewModel: viewModel)
                                .frame(height: 90)
                                .background(.clear)
                            Divider()
                            
                            // all coins view
                            CryptoCurrencyListView(viewModel: viewModel)
                                .frame(minHeight: 400)
                        }
                        
                        
                    }
                    
                    
                    if viewModel.isLoading {
                        CustomLoadingIndicator()
                    }
                }
                .background(Color.theme.appBackgroundColor)
              
            }
     
        
    }
}

struct MarketView_Previews: PreviewProvider {
    static var previews: some View {
        MarketView()
    }
}
