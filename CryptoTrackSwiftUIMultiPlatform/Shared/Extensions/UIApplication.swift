//
//  UIApplication.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 21.09.2022.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
