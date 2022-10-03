//
//  CloseButton.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 23.09.2022.
//

import SwiftUI

struct CloseButton: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
       Button(action: {
           presentationMode.wrappedValue.dismiss()
       }, label:{
           Image(systemName: "xmark")
               .font(.headline)
               .fontWeight(.bold)
               .foregroundColor(.gray)
       })
    }
}

struct CloseButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseButton()
    }
}
