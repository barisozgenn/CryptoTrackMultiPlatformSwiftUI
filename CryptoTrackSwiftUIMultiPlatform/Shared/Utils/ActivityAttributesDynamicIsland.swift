//
//  ActivityAttributesDynamicIsland.swift
//  CryptoTrackSwiftUI-iOS
//
//  Created by Baris OZGEN on 5.10.2022.
//

import Foundation
import ActivityKit

struct ActivityAttributesDynamicIsland: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var price: Double
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}
