//
//  PortfolioChart.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 23.09.2022.
//

import SwiftUI
struct PortfolioChart: View {
    
    @StateObject var viewModel : PortfolioViewModel

    var body: some View {
        
        HStack(spacing:0){
            
            // chart pie
            VStack{
                PieChartView(slices:[
                    PieChartModel(price: 4, color: .orange, title: "BTC"),
                    PieChartModel(price: 1, color: .green, title: "ETH"),
                    PieChartModel(price: 5, color: .teal, title: "CAKE"),
                    PieChartModel(price: 3, color: .yellow, title: "SRM")
                ])
            }
            .padding()
            
            // portfolio general values
            VStack(alignment: .trailing){
                
                portfolioValue(title: "Amount (BTC)", value: String(format: "%.4f", viewModel.portfolioBTCAmount))
                Divider()
                portfolioValue(title: "Invesment", value: viewModel.portfolioInvesmentPrice.toUSDCurrencyFormatted())
                Divider()
                portfolioValue(title: "Current", value: viewModel.portfolioCurrentPrice.toUSDCurrencyFormatted())
                Divider()
                portfolioValue(
                    title: "Profit & Loss",
                    value: viewModel.portfolioProfitLoss.toPercentString(),
                    valueColor: viewModel.portfolioProfitLoss.toPercentColor())
                
            }
            .padding()
            .frame(width: 140)
        }
    }
}

extension PortfolioChart {
    
    private func portfolioValue( title : String,
                                 value : String ,
                                 valueColor : Color = Color.theme.primaryTextColor) -> some View {
        
        return  VStack(alignment: .trailing){
            Text(title)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            Text(value)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(valueColor)
        }
    }
}
struct PortfolioChart_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioChart(viewModel: PortfolioViewModel())
    }
}
