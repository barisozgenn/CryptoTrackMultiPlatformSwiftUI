//
//  StatisticModel.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 15.09.2022.
//

import Foundation

struct StatisticModel: Identifiable{
    let id = UUID().uuidString
    let title : String
    let value : String
    let percentageChange : Double?
}
