//
//  View.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 20.09.2022.
//

import SwiftUI

extension View {
    
    func withSortButtonViewModifier(frameWidth: Double, isClicked: Bool) -> some View {
        modifier(SortButtonViewModifier(frameWidth: frameWidth, isClicked: isClicked))
    }
    
    func withPositiveButtonStyle(scaleValue : CGFloat = 0.9) -> some View {
        buttonStyle(PositiveButtonStyle(scaleValue: scaleValue))
    }
}
