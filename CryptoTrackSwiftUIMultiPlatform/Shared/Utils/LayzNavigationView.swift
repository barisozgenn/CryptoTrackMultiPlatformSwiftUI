//
//  LayzNavigationView.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 16.09.2022.
//

import SwiftUI

struct LayzNavigationView<Content : View> : View {
    let build: () -> Content
    
    init(build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: Content{
        build()
    }
}

