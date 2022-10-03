//
//  CurrencyImageViewModel.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 21.09.2022.
//

import SwiftUI
import Combine

class CurrencyImageViewModel: ObservableObject {
    
    @Published private(set) var image : UIImage? = nil
    @Published private(set) var isLoading : Bool = false
    
    private let cryptoCurrency: CryptoCurrency
    private let dataService: ImageDownloadService
    private var dataCancellables = Set<AnyCancellable>()

    init(cryptoCurrency: CryptoCurrency) {
        self.cryptoCurrency = cryptoCurrency
        self.dataService = ImageDownloadService(cryptoCurrency: cryptoCurrency, imageCategory: .cryptoLogo)
        self.addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers(){
        dataService.$image
            .sink{[weak self] (_) in
                self?.isLoading = false
            }receiveValue: { [weak self] (dowloadedImage) in
                self?.image = dowloadedImage
            }
            .store(in: &dataCancellables)
    }
}
