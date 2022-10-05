//
//  CryptoTrackSwiftUI_iOS_WidgetBundle.swift
//  CryptoTrackSwiftUI-iOS-Widget
//
//  Created by Baris OZGEN on 5.10.2022.
//

import WidgetKit
import SwiftUI

@main
struct CryptoTrackSwiftUI_iOS_WidgetBundle: WidgetBundle {
    var body: some Widget {
        CryptoTrackSwiftUI_iOS_Widget()
        CryptoTrackSwiftUI_iOS_WidgetLiveActivity()
    }
}
