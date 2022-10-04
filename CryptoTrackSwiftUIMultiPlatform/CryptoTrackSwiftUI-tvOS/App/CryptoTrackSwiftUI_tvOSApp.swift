//
//  CryptoTrackSwiftUI_tvOSApp.swift
//  CryptoTrackSwiftUI-tvOS
//
//  Created by Baris OZGEN on 4.10.2022.
//

import SwiftUI

@main
struct CryptoTrackSwiftUI_tvOSApp: App {
    @StateObject var launchScreenManager = LaunchScreenViewModel()
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                HomeView()
                
                if launchScreenManager.state != .completed{
                    LaunchScreenView()
                }
                
            }
            .environmentObject(launchScreenManager)
            
        }
    }
}
