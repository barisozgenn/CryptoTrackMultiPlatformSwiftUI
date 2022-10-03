//
//  CryptoTrackSwiftUI_iOSApp.swift
//  CryptoTrackSwiftUI-iOS
//
//  Created by Baris OZGEN on 3.10.2022.
//

import SwiftUI

@main
struct CryptoTrackSwiftUI_iOSApp: App {
    @StateObject var launchScreenManager = LaunchScreenViewModel()
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                RootView()
                
                if launchScreenManager.state != .completed{
                    LaunchScreenView()
                }
                
            }
            .environmentObject(launchScreenManager)
            
        }
    }
}
