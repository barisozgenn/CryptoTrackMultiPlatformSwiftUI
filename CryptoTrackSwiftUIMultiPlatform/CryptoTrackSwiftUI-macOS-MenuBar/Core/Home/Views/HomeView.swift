//
//  HomeView.swift
//  CryptoTrackSwiftUI-macOS-MenuBar
//
//  Created by Baris OZGEN on 4.10.2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var marketViewModel : MarketViewModel
    
    var body: some View {
        MarketView()
            .environmentObject(marketViewModel)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
