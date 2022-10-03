//
//  CoinDetailViewModel.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 15.09.2022.
//

import Foundation
import SwiftUI
class CoinDetailViewModel {
    
    private let cryptoCurrency : CryptoCurrency
    
    // chart Config
    var chartData = [ChartData]()
    var startChartDate = Date()
    var endChartDate = Date()
    var minChartPrice = 0.0
    var maxChartPrice = 0.0
    var xChartValues = [Date]()
    var yChartValues = [Double]()
    
    var chartGraphicLineColor : Color {
        return Color.theme.getChartGraphicLineColor(
            firstValue: cryptoCurrency.sparklineIn7D?.price.first ?? 0 ,
            lastValue: cryptoCurrency.sparklineIn7D?.price.last ?? 0)
    }
    
    var currencyName: String{
        return cryptoCurrency.name
    }
    var currencyImage: String{
        return cryptoCurrency.image
    }
    
    var overviewSectionModel : CoinDetailSectionModel {
        
        // price stats
        let price = cryptoCurrency.currentPrice.toUSDCurrency()
        let pricePercentChange = cryptoCurrency.priceChangePercentage24H
        let priceStat = StatisticModel(title: "Current Price",
                                       value: price,
                                       percentageChange: pricePercentChange)
        // market cap stats
        let marketCap = cryptoCurrency.marketCap ?? 0
        let marketCapChange = cryptoCurrency.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "Market Capitalization",
                                           value: marketCap.formattedWithAbbreviations(),
                                           percentageChange: marketCapChange)
        // rank stats
        let rank = cryptoCurrency.marketCapRank
        let rankStat = StatisticModel(title: "Rank",
                                      value: "\(rank)",
                                      percentageChange: nil)
        
        // volume stats
        let volume = cryptoCurrency.totalVolume ?? 0
        let volumeStat = StatisticModel(title: "Volume",
                                        value: volume.formattedWithAbbreviations(),
                                        percentageChange: nil)
        
        return CoinDetailSectionModel(title: "Overview", stats: [priceStat, marketCapStat, rankStat, volumeStat] )
    }
    
    var additionalDetailSectionModel : CoinDetailSectionModel {
        
        // 24H high
        let high = cryptoCurrency.high24H?.toUSDCurrency() ?? "n/a"
        let highStat = StatisticModel(title: "24h High",
                                      value: high,
                                      percentageChange: nil)
        
        // 24H low
        let low = cryptoCurrency.low24H?.toUSDCurrency() ?? "n/a"
        let lowStat = StatisticModel(title: "24h Low",
                                     value: low,
                                     percentageChange: nil)
        
        // 24H price change
        let priceChange24h = (cryptoCurrency.priceChange24H ).toUSDCurrency()
        let pricePercentChange24h = cryptoCurrency.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24h Price Change",
                                             value: priceChange24h,
                                             percentageChange: pricePercentChange24h)
        
        // 24H market cap change
        let marketCapChange = (cryptoCurrency.marketCapChange24H ?? 0)
        let marketCapPercentChange = cryptoCurrency.marketCapChangePercentage24H ?? 0
        let marketCapChangeStat = StatisticModel(title: "24h Market Cap Change",
                                                 value: "$\(marketCapChange.formattedWithAbbreviations())",
                                                 percentageChange: marketCapPercentChange)
        
        return CoinDetailSectionModel(title: "Additional Detail", stats: [
            highStat,
            lowStat,
            priceChangeStat,
            marketCapChangeStat
        ] )
    }
    
    init(cryptoCurrency: CryptoCurrency){
        self.cryptoCurrency = cryptoCurrency
        setChartData()
        
        print("DEBUG: CryptoCurrency is \(self.currencyName)")
    }
    
    func setChartData(){
        guard let priceDatas = cryptoCurrency.sparklineIn7D?.price else {return}
        
        let sortedPriceDatas = priceDatas.sorted()
        let pieces5 : Int = sortedPriceDatas.count / 5
        
        var index = 0
        
        self.minChartPrice = priceDatas.min() ?? 0
        self.maxChartPrice = priceDatas.max() ?? 0
        
        self.endChartDate = Date(coinGeckoDateString: cryptoCurrency.lastUpdated ?? "")
        self.startChartDate = endChartDate.addingTimeInterval(60 * 60 * 24 * -7)
        
        self.yChartValues = [minChartPrice, sortedPriceDatas[pieces5*1],sortedPriceDatas[pieces5*2],sortedPriceDatas[pieces5*3], maxChartPrice]
        self.xChartValues = [startChartDate, endChartDate]

        for priceData in priceDatas.reversed() {
           
            let date = self.endChartDate.addingTimeInterval(-1*60*60*Double(index))
            
            let chartData = ChartData(date: date, value: priceData)
            self.chartData.append(chartData)
            
            index += 1
        }
    }
}
