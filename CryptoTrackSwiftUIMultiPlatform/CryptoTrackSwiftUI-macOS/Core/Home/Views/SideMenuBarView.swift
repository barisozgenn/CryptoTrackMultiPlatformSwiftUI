//
//  SideMenuBarView.swift
//  CryptoTrackMacSwiftUI
//
//  Created by Baris OZGEN on 2.10.2022.
//

import SwiftUI
import AppKit


struct SideMenuBarView: View {
    @EnvironmentObject var homeViewModel : HomeViewModel

    var body: some View {
        ZStack{
            backgroundGradient
            menuList
        }
        
    }
}

extension SideMenuBarView {
    
    private var backgroundGradient : some View {
        LinearGradient(
            colors: [
                .purple,
                .blue
            ],
            startPoint: .top,
            endPoint: .bottom)
        //.blur(radius: 29)
        .opacity(0.7)
        .ignoresSafeArea()
    }
    
    private var menuList : some View {
        VStack(alignment: .center, spacing: 7){
            
            Image("logo-crypto-track-launch")
                .resizable()
                .scaledToFit()
                .frame(width: 24)
                .padding(.bottom, 14)
            
            ScrollView(.vertical){
                VStack(alignment: .leading){
                    ForEach(SideMenuBar.allCases, id: \.self){menu in
                       
                        SideMenuBarCellView(selectedMenuItem: $homeViewModel.selectedMenuItem, menu: menu)
                        .onTapGesture {
                            withAnimation(.spring()){
                                homeViewModel.selectedMenuItem = menu
                            }
                        }
                        
                        Divider()
                            .background(.white.opacity(0.07))
                    }
                }
            }
        }
        .padding(.top, 14)
    }
}


struct SideMenuBarView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuBarView()
    }
}
