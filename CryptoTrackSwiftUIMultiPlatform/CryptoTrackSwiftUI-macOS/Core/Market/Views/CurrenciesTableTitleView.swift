//
//  CurrenciesTableTitleView.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 22.09.2022.
//

import SwiftUI

struct CurrenciesTableTitleView: View {
    
    @StateObject var viewModel : MarketViewModel
    
    var body: some View {
        HStack{
            HStack{
                Text("#")
                    .frame(width: 25, alignment: .center)
            }
            .onTapGesture {
                viewModel.sortList(type: .rank)
            }
            .padding(.leading,5)
            
            HStack{
                Text("Name")
                Image(systemName: viewModel.btnNameImageDirection)
            }
            .onTapGesture {
                viewModel.sortList(type: .name)
            }
            .withSortButtonViewModifier(frameWidth: 90, isClicked: viewModel.isClickedBtnName)
            .padding(.leading,12)
            
            spacer
            
            HStack{
                Text("24h Volume")
                Image(systemName: viewModel.btnVolumeImageDirection)
            }
            .onTapGesture {
                viewModel.sortList(type: .volume)
            }
            .withSortButtonViewModifier(frameWidth: 95, isClicked: viewModel.isClickedBtnVolume)
            .padding(.leading,55)
            
            spacer
            
            HStack{
                Text("Market Cap")
                Image(systemName: viewModel.btnMarketCapImageDirection)
            }
            .onTapGesture {
                viewModel.sortList(type: .marketCap)
            }
            .withSortButtonViewModifier(frameWidth: 95, isClicked: viewModel.isClickedBtnMarketCap)
            
            
            spacer
            
            HStack{
                Text("Price")
                Image(systemName: viewModel.btnPriceImageDirection)
            }
            .onTapGesture {
                viewModel.sortList(type: .price)
            }
            .withSortButtonViewModifier(frameWidth: 55, isClicked: viewModel.isClickedBtnPrice)
            
            HStack{
                Text("24h %")
                Image(systemName: viewModel.btnPercentageImageDirection)
            }
            .onTapGesture {
                viewModel.sortList(type: .percentage)
            }
            .withSortButtonViewModifier(frameWidth: 80, isClicked: viewModel.isClickedBtnPercentage)
            
            .padding(.trailing,-10)
        }
        .frame(height: 30)
        .padding(.horizontal,2)
    }
}

extension CurrenciesTableTitleView {
    private var spacer : some View {
        Spacer()
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 40,
                maxHeight: .infinity)
    }
}
struct TableTitleView_Previews: PreviewProvider {
    static var previews: some View {
        CurrenciesTableTitleView(viewModel: MarketViewModel())
    }
}
