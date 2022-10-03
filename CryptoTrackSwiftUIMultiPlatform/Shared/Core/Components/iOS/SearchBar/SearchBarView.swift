//
//  SearchBarView.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 21.09.2022.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText : String
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ?
                        .gray : Color.theme.primaryTextColor)
            
            TextField("Search...", text: $searchText)
                .disableAutocorrection(true)
                .foregroundColor(Color.theme.primaryTextColor)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 14)
                        .foregroundColor(Color.theme.primaryTextColor)
                        .opacity(
                            searchText.isEmpty ?
                            0 : 0.6)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 29)
                .fill(Color.theme.appBackgroundColor)
                .shadow(
                    color: .black.opacity(0.29),
                    radius: 14,x: 0, y: 0
                )
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            SearchBarView(searchText: .constant(""))
                .preferredColorScheme(.dark)
        }
       
    }
}
