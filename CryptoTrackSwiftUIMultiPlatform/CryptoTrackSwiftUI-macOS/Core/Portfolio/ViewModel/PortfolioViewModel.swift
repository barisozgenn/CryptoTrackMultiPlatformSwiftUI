//
//  PortfolioViewModel.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 24.09.2022.
//

import Foundation
import Combine

class PortfolioViewModel:  ObservableObject {
    
    @Published private(set) var cryptoCurrencies = [CryptoCurrency]()
    @Published private(set) var portfolioCryptoCurrencies: [CryptoCurrency] = []
    
    private let dataService = CryptoCurrenciesService()
    private let portfolioEntityService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var searchText : String = ""
    
    @Published private(set) var portfolioBTCAmount : Double = 0
    @Published private(set) var portfolioInvesmentPrice : Double = 0
    @Published private(set) var portfolioCurrentPrice : Double = 0
    @Published private(set) var portfolioProfitLoss : Double = 0
    
    init(){
        fetchData()
        
    }
    
    private func fetchData(){
        
        $searchText
            .combineLatest(dataService.$cryptoCurrencies)
            .debounce(for: .seconds(0.7), scheduler: DispatchQueue.main)
            .map(searchCurrencies)
            .sink{[weak self] (searchedCurrencies) in
                
                self?.cryptoCurrencies = searchedCurrencies
            }
            .store(in: &cancellables)
        
        $cryptoCurrencies
            .combineLatest(portfolioEntityService.$entities)
            .map{(currencyList, portfolioEntities) -> [CryptoCurrency] in
                
                currencyList
                    .compactMap{(currency) -> CryptoCurrency? in
                        guard let entity = portfolioEntities.first(where: {$0.coinID == currency.id}) else { return nil }
                        
                        return self.calculateHoldingTotal(pEntity: entity, pEntities: portfolioEntities, currency: currency)
                        
                    }
            }
            .sink{[weak self] (portfolioCurrencies) in
                self?.portfolioCryptoCurrencies = portfolioCurrencies
                self?.calculateHoldingChart()
                
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
        
        return filteredCurrencies
    }
    
    func editPortfolio (currency : CryptoCurrency, unitPrice: Double = 0 , amount : Double = 0, trancastionType : String = "b" , crudType : PortfolioDataService.ECrudType){
        portfolioEntityService.editPortfolio(currency: currency,unitPrice: unitPrice , amount : amount, trancastionType : trancastionType, crudType: crudType)
    }
    
    private func calculateHoldingTotal(pEntity : PortfolioEntity, pEntities : [PortfolioEntity], currency : CryptoCurrency) -> CryptoCurrency {
        
        let selectedCurrencyList = pEntities.filter{ent in ent.coinID == pEntity.coinID && ent.transactionType == "b" }
        
        let totalAmount : Double = selectedCurrencyList.map { $0.amount }.reduce(0.0, +)
        let totalPrice : Double = selectedCurrencyList.map { $0.amount * $0.unitPrice }.reduce(0.0, +)
        let unitPrice : Double = totalPrice / totalAmount
        
        let unitLowestPrice : Double = selectedCurrencyList.map {$0.unitPrice}.min() ?? 0.0
        let unitHighestPrice : Double = selectedCurrencyList.map {$0.unitPrice}.max() ?? 0.0
        
        return currency.updateHolding(unitPrice: unitPrice,unitLowest: unitLowestPrice, unitHighest: unitHighestPrice, amount: totalAmount, transactionType: pEntity.transactionType ?? "b", dateCreated: pEntity.dateCreated ?? Date())
        
    }
    
    
    private func calculateHoldingChart(){
        
        portfolioInvesmentPrice = portfolioCryptoCurrencies.map {($0.portfolioUnitPrice ?? 0) * ($0.portfolioAmount ?? 0)}.reduce(0.0, +)
        portfolioCurrentPrice = portfolioCryptoCurrencies.map { $0.currentPrice * ($0.portfolioAmount ?? 0)}.reduce(0.0, +)
        
        portfolioProfitLoss = ((portfolioCurrentPrice - portfolioInvesmentPrice) / portfolioInvesmentPrice) * 100
        
        portfolioBTCAmount = portfolioInvesmentPrice / (dataService.cryptoCurrencies.first?.currentPrice ?? 00)
    }
    
}
