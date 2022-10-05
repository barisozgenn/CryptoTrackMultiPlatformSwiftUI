//
//  CryptoTrackSwiftUI_watchOSApp.swift
//  CryptoTrackSwiftUI-watchOS Watch App
//
//  Created by Baris OZGEN on 5.10.2022.
//

import SwiftUI

@main
struct CryptoTrackSwiftUI_watchOS_Watch_AppApp: App {
    @StateObject var launchScreenManager = LaunchScreenViewModel()
    @StateObject var homeViewModel = HomeViewModel()

    var body: some Scene {
        WindowGroup {
            ZStack{
                HomeView()
                    .environmentObject(homeViewModel)
                
                if launchScreenManager.state != .completed{
                    LaunchScreenView()
                }
                
            }
            .environmentObject(launchScreenManager)
            .onAppear{
                
                DispatchQueue
                    .main
                    .asyncAfter(deadline: .now() + 1.74 ) {
                        launchScreenManager.state = .completed
                        launchScreenManager.dismiss()
                        
                    }
            }
        }
    }
}
