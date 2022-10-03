//
//  HomeViewModel.swift
//  CryptoTrackMacSwiftUI
//
//  Created by Baris OZGEN on 3.10.2022.
//

import Foundation

class HomeViewModel:  ObservableObject {
    
    @Published var selectedMenuItem: SideMenuBar
    
    init() {
        self.selectedMenuItem = .market
    }
    
}
