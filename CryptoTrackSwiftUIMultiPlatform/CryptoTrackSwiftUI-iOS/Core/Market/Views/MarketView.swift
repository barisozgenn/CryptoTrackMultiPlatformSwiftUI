//
//  MarketView.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 18.09.2022.
//

import SwiftUI

struct MarketView: View {
        
    @StateObject private var viewModel = MarketViewModel()

    var body: some View {
        ZStack{
                VStack{

                    VStack{
                        // arrow and indicator
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .fontWeight(.heavy)
                            .foregroundColor(.orange)
                            .offset(y: -170)
                        
                        // top movers view
                        CryptoCurrencyHorizontalListView(viewModel: viewModel)
                        
                        Divider()
                        
                        // all coins view
                        CryptoCurrencyListView(viewModel: viewModel)
                            .frame(height: UIScreen.main.bounds.size.height-200)
                    }
                    
                    
                }
            
              if viewModel.isLoading {
                  CustomLoadingIndicator()
              }
            }
            .background(Color.theme.appBackgroundColor)
            .navigationTitle("Live Datas")
        
    }
}

struct MarketView_Previews: PreviewProvider {
    static var previews: some View {
        MarketView()
    }
}
