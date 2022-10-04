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
#if os(tvOS)
        fetchData()
#else
        fetchDataDynamic()
#endif
        
        //fetchDataDynamicDetailed()
    }
    
    //generic dynamic usage
    private func fetchDataDynamic(){
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
    
    //generic dynamic detailed usage
    private func fetchDataDynamicDetailed(){
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
        
        guard let url = URL(string: urlString) else {return}
        
        print("DEBUG : req API -> market")
        dataSubscription = NetworkCombineManager.download(url: url)
            .decode(type: [CryptoCurrency].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkCombineManager.handleCompletion ,
                  receiveValue: {[weak self] (returnedResponse) in
                self?.cryptoCurrencies = returnedResponse
                self?.dataSubscription?.cancel()
                print("DEBUG : res API -> market")
            })
    }
    
    //simple direct usage
    private func fetchData(){
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
        
        guard let url = URL(string: urlString) else {return}
        
        print("DEBUG : req combine API -> market")
        dataSubscription = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { (output) -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: [CryptoCurrency].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
                switch completion {
                case .finished:
                    print(completion)
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] (returnedResponse) in
                self?.cryptoCurrencies = returnedResponse
                self?.dataSubscription?.cancel()
                print("DEBUG : res API -> market")
            }
        
        
        
    }
    
}
