//
//  SortButtonViewModifier.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 20.09.2022.
//

import SwiftUI

struct SortButtonViewModifier: ViewModifier {
    
    let frameWidth : Double
    let isClicked : Bool
    
    func body(content: Content) -> some View {
        
        content
        .frame(width: frameWidth, alignment: .leading)
        .padding(.leading)
        .foregroundColor(isClicked ? .orange : .gray)
        .fontWeight(isClicked ? .bold : .regular)
        .font(.caption)
    }
}

struct SortButtonViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        HStack{
            Text("Name")
            Image(systemName: "arrowtriangle.up.fill")
        }.modifier(SortButtonViewModifier(frameWidth: 200, isClicked : true)
)
    }
}

