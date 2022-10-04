//
//  CryptoTrackSwiftUI_tvOSApp.swift
//  CryptoTrackSwiftUI-tvOS
//
//  Created by Baris OZGEN on 4.10.2022.
//

import SwiftUI

@main
struct CryptoTrackSwiftUI_tvOSApp: App {
    @StateObject var marketViewModel = MarketViewModel()
    @StateObject var launchScreenManager = LaunchScreenViewModel()
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                HomeView()
                    .environmentObject(marketViewModel)
                
                if launchScreenManager.state != .completed{
                    LaunchScreenView()
                }
                
            }
            .environmentObject(launchScreenManager)
            
        }
    }
}
