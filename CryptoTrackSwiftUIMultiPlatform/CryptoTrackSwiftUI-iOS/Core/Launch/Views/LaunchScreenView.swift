//
//  LaunchScreenView.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 17.09.2022.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @EnvironmentObject var launchScreenManager : LaunchScreenViewModel
    
    @State private var firstPhaseIsAnimating: Bool = false
    @State private var secondPhaseIsAnimating: Bool = false
    
    private let timer = Timer.publish(every: 0.58,
                                      on: .main,
                                      in: .common).autoconnect()
    var body: some View {
        ZStack{
            background
            logo
        }
        .onReceive(timer){input in
            
            switch launchScreenManager.state {
            case .first :
                withAnimation(.spring()){
                    firstPhaseIsAnimating.toggle()
                }
            case .second :
                withAnimation(.easeInOut){
                    secondPhaseIsAnimating.toggle()
                }
            default : break
                
            }
            
        }
        .opacity(secondPhaseIsAnimating ? 0 : 1)
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
            .environmentObject(LaunchScreenViewModel())
    }
}

private extension LaunchScreenView {
    var background: some View {
        Color("AppBackgroundColor")
            .edgesIgnoringSafeArea(.all)
    }
    
    var logo: some View {
        Image("logo-crypto-track-launch")
            .scaleEffect(firstPhaseIsAnimating ? 0.4 : 1)
            .scaleEffect(secondPhaseIsAnimating ? UIScreen.main.bounds.size.height / 4 : 1)
    }
}
