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
        
        HStack(alignment: .center, spacing:0){
            
            // chart pie
            VStack{
                PieChartView(slices:[
                    PieChartModel(price: 4, color: .orange, title: "BTC"),
                    PieChartModel(price: 1, color: .green, title: "ETH"),
                    PieChartModel(price: 5, color: .teal, title: "CAKE"),
                    PieChartModel(price: 3, color: .yellow, title: "SRM")
                ])
            }
            .frame(height: 100)
            .padding()
            
            Divider()
                .frame(height: 120)
            
            // portfolio general values
            VStack(alignment: .trailing){
                HStack{

                    portfolioValue(title: "Amount (BTC)", value: String(format: "%.4f", viewModel.portfolioBTCAmount))
                    Divider()

                    portfolioValue(title: "Invesment", value: viewModel.portfolioInvesmentPrice.toUSDCurrencyFormatted())
                    Divider()

                }
                .frame(height: 50)
                
                Divider()
                    .frame(width: 330)
                
                HStack{

                    portfolioValue(title: "Current", value: viewModel.portfolioCurrentPrice.toUSDCurrencyFormatted())
                    Divider()
                    portfolioValue(
                        title: "Profit & Loss",
                        value: viewModel.portfolioProfitLoss.toPercentString(),
                        valueColor: viewModel.portfolioProfitLoss.toPercentColor())
                    Divider()

                }
                .frame(height: 50)
               
                
               
                
            }
            .frame(width: 300)
            .padding()
        }
    }
}

extension PortfolioChart {
    
    private func portfolioValue( title : String,
                                 value : String ,
                                 valueColor : Color = Color.theme.primaryTextColor) -> some View {
        
        return  VStack(alignment: .center){
            Text(title)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            Text(value)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(valueColor)
        }
        .frame(width: 150, height: 30)
    }
}
struct PortfolioChart_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioChart(viewModel: PortfolioViewModel())
    }
}
