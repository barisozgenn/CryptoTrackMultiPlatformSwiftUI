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
    
    @Published private(set) var isClickedBtnRank = false
    @Published private(set) var isClickedBtnName = false
    @Published private(set) var isClickedBtnPrice = false
    @Published private(set) var isClickedBtnPercentage = false
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
            let tops = cryptoCurrencies.sorted(by: {$0.priceChangePercentage24H > $1.priceChangePercentage24H})
            
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
                cryptoCurrencies = cryptoCurrencies.sorted(by: { $0.priceChangePercentage24H > $1.priceChangePercentage24H })
                lastSortType = .percentageHigh
            }
            else {
                cryptoCurrencies = cryptoCurrencies.sorted(by: { $0.priceChangePercentage24H < $1.priceChangePercentage24H })
                lastSortType = .percentageLow
            }
        case .rank :
            if lastSortType == .rankLow {
                cryptoCurrencies = cryptoCurrencies.sorted(by: { $0.marketCapRank > $1.marketCapRank })
                lastSortType = .rankHigh
            }
            else {
                cryptoCurrencies = cryptoCurrencies.sorted(by: { $0.marketCapRank < $1.marketCapRank })
                lastSortType = .rankLow
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
        
        isClickedBtnRank = false
        isClickedBtnName = false
        isClickedBtnPrice = false
        isClickedBtnPercentage = false
        
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

        }
        
    }
    
    enum SortType {
        case rank
        case name
        case price
        case percentage
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
    }
}



