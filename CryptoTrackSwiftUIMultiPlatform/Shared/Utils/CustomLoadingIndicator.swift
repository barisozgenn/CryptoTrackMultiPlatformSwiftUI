//
//  CustomLoadingIndicator.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 16.09.2022.
//

import SwiftUI

struct CustomLoadingIndicator: View {
    var body: some View {
        ZStack {
            Color(white: 0, opacity: 0)
            
            Image("logo-crypto-track-launch")
                .resizable()
                .scaledToFit()
                .frame(width: 128, height: 128)
            
            ProgressView()
                 .progressViewStyle(.circular)
                 .accentColor(.white)
                 .scaleEffect(x: 1.5, y:1.5, anchor: .center)
                 .frame(width: 68, height: 68)
                 .background(
                     LinearGradient(
                     colors: [.orange, .yellow],
                     startPoint: .topLeading,
                     endPoint: .bottomTrailing
                 ))
                 .cornerRadius(58)
        }.background(ignoresSafeAreaEdges: .all)
    }
}

struct CustomLoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        CustomLoadingIndicator()
    }
}
