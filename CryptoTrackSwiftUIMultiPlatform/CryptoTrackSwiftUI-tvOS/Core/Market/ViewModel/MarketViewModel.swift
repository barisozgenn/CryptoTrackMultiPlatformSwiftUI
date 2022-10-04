//
//  MarketViewModel.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 18.09.2022.
//

import Foundation
import Combine
class MarketViewModel:  ObservableObject {
        
    @Published private(set) var cryptoCurrencies = [CryptoCurrency]()
    @Published private(set) var topCryptoCurrencies = [CryptoCurrency]()
    
    @Published private(set) var btnRankImageDirection = ""
    @Published private(set) var btnNameImageDirection = ""
    @Published private(set) var btnPriceImageDirection = ""
    @Published private(set) var btnPercentageImageDirection = ""
    @Published private(set) var btnVolumeImageDirection = ""
    @Published private(set) var btnMarketCapImageDirection = ""

    private(set) var isClickedBtnRank = false
    private(set) var isClickedBtnName = false
    private(set) var isClickedBtnPrice = false
    private(set) var isClickedBtnPercentage = false
    private(set) var isClickedBtnVolume = false
    private(set) var isClickedBtnMarketCap = false
    
    @Published var isLoading = true

    @Published var searchText : String = ""
    
    private var lastSortType : ListSortType = .rankLow
    
    private let dataService = CryptoCurrenciesService()
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        
        fetchData()
        setSortButtonStyle()
    }
    
    private func fetchData(){
        
         $searchText
             .combineLatest(dataService.$cryptoCurrencies)
             .debounce(for: .seconds(0.7), scheduler: DispatchQueue.main)
             .map(searchCurrencies)
             .sink{[weak self] (searchedCurrencies) in
                
                 self?.cryptoCurrencies = searchedCurrencies
                 self?.sortTopMovingCryptoCurrencies()

                 self?.isLoading = false

             }
             .store(in: &cancellables)
         
    }
    
    private func searchCurrencies(text:String, searchCurrencies : [CryptoCurrency]) -> [CryptoCurrency]{
        
        guard !text.isEmpty else {
            return searchCurrencies
        }
        
        let lowercasedText = text.lowercased()
        
        let filteredCurrencies = searchCurrencies.filter { (crypto) -> Bool in
            let condition =
            crypto.name.lowercased().contains(lowercasedText) ||
            crypto.symbol.lowercased().contains(lowercasedText)
            
            return condition
        }
        
        sortList(type: .name)
        
        return filteredCurrencies
    }
    
    func sortTopMovingCryptoCurrencies(){
        if cryptoCurrencies.count > 5 {
            let tops = cryptoCurrencies.sorted(by: {$0.priceChangePercentage24H ?? 0 > $1.priceChangePercentage24H ?? 0 })
            
            self.topCryptoCurrencies = Array(tops.prefix(5))
        }
        
    }
    
    func refreshData(){
        print("DEBUG: Refresh data triggered")
        fetchData()
    }
    
    func sortList(type: SortType){
        
        switch type {
        case .price :
            if lastSortType == .priceLow {
                cryptoCurrencies = cryptoCurrencies.sorted(by: { $0.currentPrice > $1.currentPrice })
                lastSortType = .priceHigh
            }
            else {
                cryptoCurrencies = cryptoCurrencies.sorted(by: { $0.currentPrice < $1.currentPrice })
                lastSortType = .priceLow
            }
        case .name :
            if lastSortType == .nameAsc {
                cryptoCurrencies = cryptoCurrencies.sorted(by: { $0.name.lowercased() > $1.name.lowercased() })
                lastSortType = .nameDesc
            }
            else {
                cryptoCurrencies = cryptoCurrencies.sorted(by: { $0.name.lowercased() < $1.name.lowercased() })
                lastSortType = .nameAsc
            }
        case .percentage :
            if lastSortType == .percentageLow {
                cryptoCurrencies = cryptoCurrencies.sorted(by: { $0.priceChangePercentage24H ?? 0  > $1.priceChangePercentage24H ?? 0  })
                lastSortType = .percentageHigh
            }
            else {
                cryptoCurrencies = cryptoCurrencies.sorted(by: { $0.priceChangePercentage24H ?? 0  < $1.priceChangePercentage24H ?? 0  })
                lastSortType = .percentageLow
            }
        case .rank :
            if lastSortType == .rankLow {
                cryptoCurrencies = cryptoCurrencies.sorted(by: { $0.marketCapRank ?? 0  > $1.marketCapRank ?? 0  })
                lastSortType = .rankHigh
            }
            else {
                cryptoCurrencies = cryptoCurrencies.sorted(by: { $0.marketCapRank ?? 0  < $1.marketCapRank ?? 0  })
                lastSortType = .rankLow
            }
        case .volume:
            if lastSortType == .volumeLow {
                cryptoCurrencies = cryptoCurrencies.sorted(by: { $0.totalVolume ?? 0 > $1.totalVolume ?? 0 })
                lastSortType = .volumeHigh
            }
            else {
                cryptoCurrencies = cryptoCurrencies.sorted(by: { $0.totalVolume ?? 0 < $1.totalVolume ?? 0 })
                lastSortType = .volumeLow
            }
        case .marketCap:
            if lastSortType == .marketCapLow {
                cryptoCurrencies = cryptoCurrencies.sorted(by: { $0.marketCap ?? 0 > $1.marketCap ?? 0 })
                lastSortType = .marketCapHigh
            }
            else {
                cryptoCurrencies = cryptoCurrencies.sorted(by: { $0.marketCap ?? 0 < $1.marketCap ?? 0 })
                lastSortType = .marketCapLow
            }
        }
        
        setSortButtonStyle()
    }
    
    private func setSortButtonStyle(){
        
        let downArrowEmpty = "arrowtriangle.down"
        let downArrow = "arrowtriangle.down.fill"
        let upArrow = "arrowtriangle.up.fill"
        
        btnRankImageDirection = downArrowEmpty
        btnNameImageDirection = downArrowEmpty
        btnPriceImageDirection = downArrowEmpty
        btnPercentageImageDirection = downArrowEmpty
        btnVolumeImageDirection = downArrowEmpty
        btnMarketCapImageDirection = downArrowEmpty

        isClickedBtnRank = false
        isClickedBtnName = false
        isClickedBtnPrice = false
        isClickedBtnPercentage = false
        isClickedBtnVolume = false
        isClickedBtnMarketCap = false

        switch lastSortType {
        case .rankLow:
            btnRankImageDirection = downArrow
            isClickedBtnRank = true

        case .rankHigh:
            btnRankImageDirection = upArrow
            isClickedBtnRank = true

        case .nameAsc:
            btnNameImageDirection = downArrow
            isClickedBtnName = true

        case .nameDesc:
            btnNameImageDirection = upArrow
            isClickedBtnName = true

        case .priceLow:
            btnPriceImageDirection = upArrow
            isClickedBtnPrice = true

        case .priceHigh:
            btnPriceImageDirection = downArrow
            isClickedBtnPrice = true

        case .percentageLow:
            btnPercentageImageDirection = upArrow
            isClickedBtnPercentage = true

        case .percentageHigh:
            btnPercentageImageDirection = downArrow
            isClickedBtnPercentage = true

        case .volumeLow:
            btnVolumeImageDirection = upArrow
            isClickedBtnVolume = true
            
        case .volumeHigh:
            btnVolumeImageDirection = downArrow
            isClickedBtnVolume = true
            
        case .marketCapLow:
            btnMarketCapImageDirection = upArrow
            isClickedBtnMarketCap = true
        case .marketCapHigh:
            btnMarketCapImageDirection = downArrow
            isClickedBtnMarketCap = true
        }
        
    }
    
    enum SortType {
        case rank
        case name
        case price
        case percentage
        case volume
        case marketCap
    }
    
    private enum ListSortType {
        case rankLow
        case rankHigh
        case nameAsc
        case nameDesc
        case priceLow
        case priceHigh
        case percentageLow
        case percentageHigh
        case volumeLow
        case volumeHigh
        case marketCapLow
        case marketCapHigh
    }
}



