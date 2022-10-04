//
//  LaunchScreenViewModel.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 17.09.2022.
//

import Foundation

enum LaunchScreenPhase {
    case first
    case second
    case completed
}
final class LaunchScreenViewModel: ObservableObject {
    @Published private(set) var state: LaunchScreenPhase = .first
    
    func dismiss(){
        self.state = .second
        
        DispatchQueue
            .main
            .asyncAfter(deadline: .now() + 1.14 ) {
                self.state = .completed
            }
    }
}
