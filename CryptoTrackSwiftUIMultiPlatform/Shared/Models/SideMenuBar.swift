//
//  SideMenuBar.swift
//  CryptoTrackMacSwiftUI
//
//  Created by Baris OZGEN on 2.10.2022.
//

import Foundation

enum SideMenuBar: Int, CaseIterable, Identifiable {
    
    case market
    case portfolio
    case news
    case settings
    
    var id : Int { return rawValue}
    
    var title : String {
        switch self {
        case .market: return "Markets"
        case .portfolio: return "Portfolio"
        case .news: return "News"
        case .settings: return "Settings"
        }
    }
    
    var imageName : String {
        switch self {
        case .market: return "chart.bar.xaxis"
        case .portfolio: return "chart.pie.fill"
        case .news: return "newspaper.fill"
        case .settings: return "gearshape.fill"
        }
    }
    
}
