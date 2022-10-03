//
//  CurrencyImageView.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 21.09.2022.
//

import SwiftUI

struct CurrencyImageView: View {
    
    @StateObject var vm : CurrencyImageViewModel
    
    init(cryptoCurrency : CryptoCurrency) {
        _vm = StateObject(wrappedValue: CurrencyImageViewModel(cryptoCurrency: cryptoCurrency))
    }
    
    var body: some View {
        ZStack{
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "photo.circle.fill")
                    .foregroundColor(.gray)
            }
        }
    }
}

struct CurrencyImageView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyImageView(cryptoCurrency: dev.cryptoCurrency)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
