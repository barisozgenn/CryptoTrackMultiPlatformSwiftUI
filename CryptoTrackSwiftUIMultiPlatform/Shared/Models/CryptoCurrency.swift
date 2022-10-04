//
//  CryptoCurrency.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 14.09.2022.
//

import Foundation


// MARK: - CryptoCurrency
struct CryptoCurrency: Codable, Identifiable {
    let id,symbol,name: String
    let image: String
    let currentPrice: Double
    let marketCapRank: Int?
    let marketCap: Double?
    let totalVolume,high24H,low24H: Double?
    
    let priceChange24H: Double?
    let priceChangePercentage24H :Double?
    let marketCapChange24H, marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    
    let portfolioAmount : Double?
    let portfolioUnitPrice : Double?
    let portfolioUnitLowest : Double?
    let portfolioUnitHighest : Double?
    let portfolioTransactionType : String?
    let portfolioDateCreated : Date?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        
        
        case portfolioAmount
        case portfolioUnitPrice
        case portfolioUnitLowest
        case portfolioUnitHighest
        case portfolioTransactionType
        case portfolioDateCreated
    }
    
    func updateHolding(unitPrice : Double, unitLowest : Double, unitHighest : Double, amount: Double, transactionType : String, dateCreated: Date) -> CryptoCurrency {
        return CryptoCurrency(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCapRank: marketCapRank, marketCap: marketCap, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D,
                              
                              portfolioAmount : amount,
                              portfolioUnitPrice : unitPrice,
                              portfolioUnitLowest : unitLowest,
                              portfolioUnitHighest : unitHighest,
                              portfolioTransactionType: transactionType,
                              portfolioDateCreated: dateCreated)
    }
}

// MARK: - SparklineIn7D
struct SparklineIn7D: Codable {
    let price: [Double]
}
