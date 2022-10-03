//
//  ChartData.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 15.09.2022.
//

import Foundation

struct ChartData : Identifiable{
    let id = UUID().uuidString
    let date: Date
    let value: Double
}
