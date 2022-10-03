//
//  Date.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 15.09.2022.
//

import Foundation

extension Date {
    
    init(coinGeckoDateString: String){
        let formetter = DateFormatter()
        formetter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"//"2022-09-15T08:26:52.857Z"
        
        let date = formetter.date(from: coinGeckoDateString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    private var shortDateFormatter : DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        return formatter
    }
    
    func asShortDateString() -> String {
        return shortDateFormatter.string(from: self)
    }
}
