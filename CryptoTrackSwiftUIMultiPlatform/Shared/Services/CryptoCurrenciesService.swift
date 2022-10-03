//
//  CryptoCurrenciesService.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 21.09.2022.
//

import Foundation
import SwiftUI
import Combine

class CryptoCurrenciesService {
    @Published var cryptoCurrencies = [CryptoCurrency]()
    
    var dataSubscription: AnyCancellable?
    
    init() {
       fetchData()
    }
    
    private func fetchData(){
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
        
        guard let url = URL(string: urlString) else {return}
        
        print("DEBUG : req API -> market")
        dataSubscription = NetworkManager.download(url: url)
            .decode(type: [CryptoCurrency].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion ,
                  receiveValue: {[weak self] (returnedResponse) in
                
                self?.cryptoCurrencies = returnedResponse                
                self?.dataSubscription?.cancel()
                print("DEBUG : res API -> market")
            })
        
        
    }
}
