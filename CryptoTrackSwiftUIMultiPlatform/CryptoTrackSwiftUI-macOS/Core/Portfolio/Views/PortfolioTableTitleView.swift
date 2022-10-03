//
//  PortfolioTableTitleView.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 23.09.2022.
//

import SwiftUI

struct PortfolioTableTitleView: View {
    var body: some View {
        HStack{
            Text("Name")
                .frame(width: 60, alignment: .center)
                .padding(.leading, 29)
            
            Text("Profit")
                .frame(width: 60, alignment: .center)
            
            spacer
            
            Text("Lowest Unit Price")
                .frame(width: 150, alignment: .center)
            
            spacer
            
            Text("Highest Unit Price")
                .frame(width: 150, alignment: .center)
            
            spacer
            
            Text("Unit Price")
                .frame(width: 80, alignment: .center)
            Text("Price")
                .frame(width: 80, alignment: .center)
        }
        .frame(height: 30)
        .padding(.horizontal,2)
        .foregroundColor(.gray)
        .font(.caption)
    }
}

extension PortfolioTableTitleView {
    private var spacer : some View {
        Spacer()
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 40,
                maxHeight: .infinity)
    }
}
struct PortfolioTableTitleView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioTableTitleView()
    }
}
