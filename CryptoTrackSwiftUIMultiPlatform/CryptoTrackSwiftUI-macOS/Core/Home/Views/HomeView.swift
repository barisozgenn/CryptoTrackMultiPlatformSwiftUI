//
//  HomeView.swift
//  CryptoTrackMacSwiftUI
//
//  Created by Baris OZGEN on 2.10.2022.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    @EnvironmentObject var marketViewModel : MarketViewModel
    @EnvironmentObject var portfolioViewModel : PortfolioViewModel
    
    var body: some View {
        NavigationView(content: {
            SideMenuBarView()
                .environmentObject(viewModel)
                .frame(idealWidth: 120)
            
            contentView
        })
        .toolbar {
            
            ToolbarItem(placement: .navigation) {
                
                HStack(spacing: 2) {
                    Image(systemName: viewModel.selectedMenuItem.imageName)
                        .frame(width: 48, height: 48)
                        .foregroundColor(.white)
                    Text(viewModel.selectedMenuItem.title).font(.headline)
                }
            }
            
        }
        .toolbarBackground(
            LinearGradient(
                colors: [
                    .purple,
                    .blue
                ],
                startPoint: .bottomLeading,
                endPoint: .topTrailing),
            for: .windowToolbar)
        .toolbarBackground(.visible, for: .windowToolbar)
        .background(Color.theme.appBackgroundColor.preferredColorScheme(.dark))
        
    }
}

extension HomeView {
    private var contentView : some View {
        ZStack{
            switch viewModel.selectedMenuItem {
            case .market:  MarketView().environmentObject(marketViewModel)
            case .portfolio:  PortfolioView().environmentObject(portfolioViewModel)
            default: MarketView().environmentObject(marketViewModel)
            }
        }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
