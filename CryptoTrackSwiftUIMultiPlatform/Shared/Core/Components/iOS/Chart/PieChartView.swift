//
//  PieChartView.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 23.09.2022.
//

import SwiftUI

struct PieChartView: View {
    
    @State var slices: [PieChartModel]
    
    var body: some View {
        VStack{
            Canvas { context, size in
                
                
                let total = slices.reduce(0, {$0 + $1.price})
                
                context.translateBy(x: size.width * 0.5, y: size.height * 0.5)
                var pieContext = context
                pieContext.rotate(by: .degrees(-90))
                let radius = min(size.width, size.height) * 0.48
                var startAngle = Angle.zero
                
                slices.forEach{ slice in
                    
                    let value = slice.price
                    let color = slice.color
                    
                    let angle = Angle(degrees: 360 * (value / total))
                    let endAngle = startAngle + angle
                    
                    
                    
                    let path = Path { p in
                        p.move(to: .zero)
                        p.addArc(center: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                        p.closeSubpath()
                        
                    }
                    pieContext.fill(path, with: .color(color))
                    
                    startAngle = endAngle
                }
                
            }
            .aspectRatio(1, contentMode: .fit)
            
            
            ScrollView(.horizontal) {
               HStack{
                    let total = slices.reduce(0, {$0 + $1.price})

                    ForEach(slices){slice in
                        
                        let avg = (slice.price / total) * 100
                        Text("■ \(slice.title) %\(avg.asNumberString())")
                            .foregroundColor(slice.color)
                            .fontWeight(.bold)
                            .font(.system(size: 13))
                    }
                }
            }
           
            
            
            
            
        }
        
        
    }
}


struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView(slices: [
            PieChartModel(price: 4, color: .yellow, title: "BTC"),
            PieChartModel(price: 1, color: .green, title: "ETH"),
            PieChartModel(price: 14, color: .blue, title: "CAKE"),
            PieChartModel(price: 4, color: .indigo, title: "MITH")/*,
            PieChartModel(price: 2, color: .purple, title: "LIT")*/
        ])
    }
}
