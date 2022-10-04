//
//  HomeView.swift
//  CryptoTrackSwiftUI-tvOS
//
//  Created by Baris OZGEN on 4.10.2022.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var launchScreenManager : LaunchScreenViewModel

    var body: some View {
        ZStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
