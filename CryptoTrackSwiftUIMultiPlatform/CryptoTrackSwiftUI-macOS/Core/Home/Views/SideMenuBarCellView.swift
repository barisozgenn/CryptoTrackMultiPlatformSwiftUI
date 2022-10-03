//
//  SideMenuBarCellView.swift
//  CryptoTrackMacSwiftUI
//
//  Created by Baris OZGEN on 2.10.2022.
//

import SwiftUI

struct SideMenuBarCellView: View {
    
    @Binding var selectedMenuItem: SideMenuBar

    @State private var hoverMenuItem = false
    let menu : SideMenuBar
    
    var body: some View {
        HStack(alignment: .center){
            Image(systemName: menu.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 16)
                .shadow(
                    color: .black.opacity(0.14),
                    radius: 1,x: 0, y: 1
                )
            VStack{
                
                Text(menu.title)
                    .fontWeight(.semibold)
                    .font(.caption)
                    .shadow(
                        color: .black.opacity(0.14),
                        radius: 1,x: 1, y: 1
                    )
                
                
            }
            .padding(.horizontal, 4)
            
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .resizable()
                .scaledToFit()
                .frame(width: 8)
                .shadow(
                    color: .black.opacity(0.14),
                    radius: 1,x: 0, y: 1
                )
                .opacity((hoverMenuItem || selectedMenuItem == menu) ? 1 : 0 )
                .padding(.horizontal, 14)
            

        }
        .padding(.leading, 14)
        .frame(minWidth: 77, minHeight: 45)
        .foregroundColor((hoverMenuItem || selectedMenuItem == menu) ? .orange : .white)
        .onHover { hover in
            withAnimation(.spring()){
                hoverMenuItem = hover
            }
        }
    }
}

struct SideMenuBarCellView_Previews: PreviewProvider {
    static var previews: some View {
       SideMenuBarCellView(selectedMenuItem: .constant(.market), menu: .portfolio)
            .preferredColorScheme(.dark)
    }
}
