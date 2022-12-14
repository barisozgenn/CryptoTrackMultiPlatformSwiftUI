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
            if launchScreenManager.state != .completed {
                background
                logo
            }
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

private extension LaunchScreenView {
    var background: some View {
        Color(.black)
            .edgesIgnoringSafeArea(.all)
    }
    
    var logo: some View {
        Image("logo-crypto-track-launch")
            .scaleEffect(firstPhaseIsAnimating ? 0.4 : 1)
#if os(watchOS)
            .scaleEffect(secondPhaseIsAnimating ? WKInterfaceDevice.current().screenBounds.size.height / 4 : 1)
#elseif os(macOS)
            .scaleEffect(secondPhaseIsAnimating ? main?.visibleFrame.size.height / 4 : 1)
#else
            .scaleEffect(secondPhaseIsAnimating ? UIScreen.main.bounds.size.height / 4 : 1)
#endif
    }
}


struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
            .environmentObject(LaunchScreenViewModel())
    }
}
