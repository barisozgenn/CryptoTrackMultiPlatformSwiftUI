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
    let price : String = "$20.297,92"
    let percentage : String = "+%7.29"
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ActivityAttributesDynamicIsland.self) { context in
            // Lock screen/banner UI goes here
            // height maximum : 220px
            
            // btc
            contentView
            .activityBackgroundTint(Color.purple)
            .activitySystemActionForegroundColor(Color.blue)
            
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
              
                
                DynamicIslandExpandedRegion(.leading) {
                    
                }
                DynamicIslandExpandedRegion(.trailing) {
                }
                DynamicIslandExpandedRegion(.bottom) {
                    contentView
                    // more content
                }
            } compactLeading: {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.orange)
            } compactTrailing: {
                Text(percentage)
                    .font(.system(size: 10))
                    .fontWeight(.bold)
                    .foregroundColor(Color.theme.currencyGreenColor)
            } minimal: {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
            }
            .widgetURL(URL(string: "https://www.github.com/barisozgenn"))
            .keylineTint(Color.green)
        }
    }
    
    
    private var contentView : some View {
        ZStack{
            VStack{
                HStack{
                    VStack(alignment: .leading){
                        Text("BTC")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color(.white))
                        
                        Text("Bitcoin")
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
                            .foregroundColor(Color.theme.currencyGreenColor)
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

