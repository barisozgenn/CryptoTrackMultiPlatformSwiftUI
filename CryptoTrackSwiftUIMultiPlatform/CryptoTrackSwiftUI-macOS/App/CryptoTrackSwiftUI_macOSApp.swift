//
//  CryptoTrackSwiftUI_macOSApp.swift
//  CryptoTrackSwiftUI-macOS
//
//  Created by Baris OZGEN on 3.10.2022.
//

import SwiftUI

@main
struct CryptoTrackSwiftUI_macOSApp: App {
    @StateObject var marketViewModel = MarketViewModel()
    @StateObject var portfolioViewModel = PortfolioViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(marketViewModel)
                .environmentObject(portfolioViewModel)
                
        }
       .windowStyle(.hiddenTitleBar)
    }
}
