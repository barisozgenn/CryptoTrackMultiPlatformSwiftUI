//
//  AddButton.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 23.09.2022.
//

import SwiftUI

struct AddButton: View {
    @StateObject var viewModel : PortfolioViewModel
    
    var body: some View {
      
            NavigationLink{
              LayzNavigationView(build: PortfolioSelectGridView(viewModel: viewModel))
            }
        label:{
            
            ZStack{
                Image(systemName: "plus")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(14)
                    .background(.blue)
                    .cornerRadius(.infinity)
            }
            .withPositiveButtonStyle()
            
        }
            
        
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        AddButton(viewModel: PortfolioViewModel())
    }
}
