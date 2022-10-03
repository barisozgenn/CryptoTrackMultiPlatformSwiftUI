//
//  PieChartModel.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 23.09.2022.
//

import Foundation
import SwiftUI

struct PieChartModel : Identifiable{
    let id = UUID().uuidString
    let price: Double
    let color: Color
    let title : String
}

