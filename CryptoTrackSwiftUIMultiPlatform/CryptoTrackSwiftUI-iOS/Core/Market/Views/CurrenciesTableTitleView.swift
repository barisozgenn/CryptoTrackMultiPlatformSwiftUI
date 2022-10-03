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
            
            Spacer()
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: 50)
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

struct TableTitleView_Previews: PreviewProvider {
    static var previews: some View {
        CurrenciesTableTitleView(viewModel: MarketViewModel())
    }
}
