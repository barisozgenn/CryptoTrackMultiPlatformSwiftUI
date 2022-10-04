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
#if os(tvOS)
                    .font(.system(size: 14))
#endif
                
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
#if os(tvOS)
            .withSortButtonViewModifier(frameWidth: 120, isClicked: viewModel.isClickedBtnPercentage)
#else
            .withSortButtonViewModifier(frameWidth: 90, isClicked: viewModel.isClickedBtnPercentage)
#endif
            .padding(.leading,12)
            
            spacer
            
            HStack{
                Text("24h Volume")
                Image(systemName: viewModel.btnVolumeImageDirection)
            }
            .onTapGesture {
                viewModel.sortList(type: .volume)
            }
#if os(tvOS)
            .withSortButtonViewModifier(frameWidth: 155, isClicked: viewModel.isClickedBtnPercentage)
            .padding(.leading,85)
#else
            .withSortButtonViewModifier(frameWidth: 95, isClicked: viewModel.isClickedBtnPercentage)
            .padding(.leading,55)
#endif
            
            
            spacer
            
            HStack{
                Text("Market Cap")
                Image(systemName: viewModel.btnMarketCapImageDirection)
            }
            .onTapGesture {
                viewModel.sortList(type: .marketCap)
            }
#if os(tvOS)
            .withSortButtonViewModifier(frameWidth: 150, isClicked: viewModel.isClickedBtnPercentage)
#else
            .withSortButtonViewModifier(frameWidth: 95, isClicked: viewModel.isClickedBtnPercentage)
#endif
            
            
            spacer
            
            HStack{
                Text("Price")
                Image(systemName: viewModel.btnPriceImageDirection)
            }
            .onTapGesture {
                viewModel.sortList(type: .price)
            }
#if os(tvOS)
            .withSortButtonViewModifier(frameWidth: 110, isClicked: viewModel.isClickedBtnPercentage)
#else
            .withSortButtonViewModifier(frameWidth: 55, isClicked: viewModel.isClickedBtnPercentage)
#endif
            
            HStack{
                Text("24h %")
                Image(systemName: viewModel.btnPercentageImageDirection)
            }
            .onTapGesture {
                viewModel.sortList(type: .percentage)
            }
#if os(tvOS)
            .withSortButtonViewModifier(frameWidth: 120, isClicked: viewModel.isClickedBtnPercentage)
#else
            .withSortButtonViewModifier(frameWidth: 80, isClicked: viewModel.isClickedBtnPercentage)
            .padding(.trailing,-10)
#endif
            
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
