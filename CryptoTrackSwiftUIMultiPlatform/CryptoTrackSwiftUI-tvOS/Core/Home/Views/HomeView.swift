//
//  HomeView.swift
//  CryptoTrackSwiftUI-tvOS
//
//  Created by Baris OZGEN on 4.10.2022.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var launchScreenManager : LaunchScreenViewModel

    @EnvironmentObject var marketViewModel : MarketViewModel
    
    var body: some View {
        ZStack{
            MarketView()
                .environmentObject(marketViewModel)
        }
        .onAppear{
                        
            DispatchQueue
                .main
                .asyncAfter(deadline: .now() + 1.74 ) {
                    launchScreenManager.dismiss()
                }
        }
       
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
