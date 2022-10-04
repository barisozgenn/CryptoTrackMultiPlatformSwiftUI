//
//  StatisticView.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 15.09.2022.
//

import SwiftUI

struct StatisticView: View {
    let model : StatisticModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(model.title)
                .font(.caption)
            
            Text(model.value)
                .font(.headline)
            
            if let percentChange = model.percentageChange {
                
                HStack(spacing: 4){
                    Image(systemName: percentChange.getImageArrowSystemName())
                        .font(.caption)
                    
                    Text(percentChange.toPercentString())
                        .font(.caption)
                        .bold()
                }
                .foregroundColor(percentChange.toPercentColor())
            }
           
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView(model: dev.stat0x1)
    }
}
