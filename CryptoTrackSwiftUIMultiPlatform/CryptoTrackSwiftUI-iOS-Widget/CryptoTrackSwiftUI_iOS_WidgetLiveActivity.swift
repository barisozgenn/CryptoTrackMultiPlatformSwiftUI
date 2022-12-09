//
//  CryptoTrackSwiftUI_iOS_WidgetLiveActivity.swift
//  CryptoTrackSwiftUI-iOS-Widget
//
//  Created by Baris OZGEN on 5.10.2022.
//

import ActivityKit
import WidgetKit
import SwiftUI



struct CryptoTrackSwiftUI_iOS_WidgetLiveActivity: Widget {
    
    let imageName : String = "bitcoinsign.circle.fill"
    
    var body: some WidgetConfiguration {
        
        ActivityConfiguration(for: ActivityAttributesDynamicIsland.self) { context in
            // Lock screen/banner UI goes here
            // height maximum : 220px
            
            // btc
            CustomContentView(price: context.attributes.model.currentPrice.toUSDCurrencyFormatted(),
                              percentage: (context.attributes.model.priceChangePercentage24H ?? 0.0).toPercentString(),
                              symbol: context.attributes.model.symbol,
                              name: context.attributes.model.name)
            .activityBackgroundTint(Color.purple)
            .activitySystemActionForegroundColor(Color.blue)
        }
    dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
            
                
                DynamicIslandExpandedRegion(.leading) {
                    
                }
                DynamicIslandExpandedRegion(.trailing) {
                }
                DynamicIslandExpandedRegion(.bottom) {
                    CustomContentView(price: context.attributes.model.currentPrice.toUSDCurrencyFormatted(),
                                      percentage: (context.attributes.model.priceChangePercentage24H ?? 0.0).toPercentString(),
                                      symbol: context.attributes.model.symbol,
                                      name: context.attributes.model.name)
                       
                    // more content
                }
            } compactLeading: {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.orange)
            } compactTrailing: {
                Text((context.attributes.model.priceChangePercentage24H ?? 0.0).toPercentString())
                    .font(.system(size: 10))
                    .fontWeight(.bold)
                    .foregroundColor((context.attributes.model.priceChangePercentage24H ?? 0.0) > 0 ? .green : .red)
            } minimal: {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
            }
            .widgetURL(URL(string: "https://www.github.com/barisozgenn"))
            .keylineTint(Color.green)
            
        }
    }
    
    struct CustomContentView : View {
        let imageName : String = "bitcoinsign.circle.fill"
        @State var price : String = ""
        @State var percentage : String = ""
        @State var symbol: String = ""
        @State var name: String = ""
        var body: some View {
            ZStack{
                VStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text(symbol.uppercased())
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.white))
                            
                            Text(name.capitalized)
                                .font(.caption)
                                .foregroundColor(Color(.white))
                        }
                        
                        
                        Spacer()
                        Text(price)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        // 24h Change
                        VStack{
                            Text(percentage)
                                .font(.system(size: 11))
                                .fontWeight(.black)
                                .foregroundColor(.green)
                        }
                        .frame(width: 55)
                        .padding(.vertical, 11)
                        .padding(.horizontal,3)
                        .background(Color(.systemGray6))
                        .cornerRadius(4)
                    }
                    
                }
                .padding(.horizontal)
            }
        }
    }
}

