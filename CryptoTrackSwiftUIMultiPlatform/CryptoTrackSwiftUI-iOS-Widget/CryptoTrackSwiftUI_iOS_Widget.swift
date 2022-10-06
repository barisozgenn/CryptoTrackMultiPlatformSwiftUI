//
//  CryptoTrackSwiftUI_iOS_Widget.swift
//  CryptoTrackSwiftUI-iOS-Widget
//
//  Created by Baris OZGEN on 5.10.2022.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}



struct CryptoTrackSwiftUI_iOS_WidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    
    let imageName : String = "bitcoinsign.circle.fill"
    let price : String = "$20.297,92"
    let percentage : String = "+%7.29"
    
    var entry: Provider.Entry
    
    var body: some View {
        
        switch widgetFamily {
        case .accessoryInline:
            HStack(spacing: 2){
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                Text(price)
                    .fontWeight(.semibold)
                    .font(.system(size: 16))
            }
            .foregroundColor(.green)
            .frame(width: .infinity, height: 30)
        case .accessoryCircular:
            Gauge(value: 0.5729){
                VStack(spacing: 2){
                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                    Text("$20.297")
                        .fontWeight(.semibold)
                        .font(.system(size: 8))
                    Text(percentage)
                        .fontWeight(.bold)
                        .font(.system(size: 7))
                }
                .foregroundColor(.green)
                .frame(width: 46, height: 46)
                .offset(x:0 ,y: -14)
            }
            .gaugeStyle(.accessoryCircular)
            .foregroundColor(.green)
        case .accessoryRectangular:
            Gauge(value: 0.5729){
                HStack(spacing: 2){
                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                    Spacer()
                    VStack(alignment: .trailing){
                        Text(price)
                            .fontWeight(.semibold)
                            .font(.system(size: 16))
                        Text(percentage)
                            .fontWeight(.bold)
                            .font(.system(size: 12))
                    }
                }
                .foregroundColor(.green)
                .frame(width: .infinity, height: 30)
            }
            .gaugeStyle(.linearCapacity)
            .foregroundColor(.green)
        case .systemExtraLarge, .systemLarge:
            ZStack{
                
                LinearGradient(
                    colors: [
                        .purple,
                        .blue
                    ],
                    startPoint: .bottomLeading,
                    endPoint: .topTrailing
                )
                VStack(spacing: 10){
                    // btc
                    VStack{
                        HStack{
                            VStack(alignment: .leading){
                                Text("BTC")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemGray6))
                                
                                Text("Bitcoin")
                                    .font(.caption)
                                    .foregroundColor(Color(.systemGray3))
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
                    
                    Divider()
                        .background(.white)
                    
                    // eth
                    VStack{
                        HStack{
                            VStack(alignment: .leading){
                                Text("ETH")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemGray6))
                                
                                Text("Ethereum")
                                    .font(.caption)
                                    .foregroundColor(Color(.systemGray3))
                            }
                            
                            
                            Spacer()
                            Text("$1.314,07")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            // 24h Change
                            VStack{
                                Text("-%1.92")
                                    .font(.system(size: 11))
                                    .fontWeight(.black)
                                    .foregroundColor(.red)
                            }
                            .frame(width: 55)
                            .padding(.vertical, 11)
                            .padding(.horizontal,3)
                            .background(Color(.systemGray6))
                            .cornerRadius(4)
                        }
                        
                    }
                    
                    Divider()
                        .background(.white)
                    
                    HStack{
                        // cake
                        VStack{
                            HStack{
                                VStack(alignment: .leading){
                                    Text("CAKE")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(.systemGray6))
                                    
                                    Text("PancakeSwap")
                                        .font(.caption2)
                                        .foregroundColor(Color(.systemGray3))
                                }
                                
                                
                                Spacer()
                                
                                // price
                                VStack{
                                    Text("$4,72")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    
                                    Text("+%2.14")
                                        .font(.system(size: 11))
                                        .fontWeight(.black)
                                        .foregroundColor(.green)
                                }
                                
                            }
                            
                        }
                        
                        Divider()
                            .background(.white)
                            .frame(height: 50)
                        // srm
                        VStack{
                            HStack{
                                VStack(alignment: .leading){
                                    Text("SRM")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(.systemGray6))
                                    
                                    Text("Serum")
                                        .font(.caption2)
                                        .foregroundColor(Color(.systemGray3))
                                }
                                
                                
                                Spacer()
                                
                                // price
                                VStack{
                                    Text("$0,72")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    
                                    Text("+%0.58")
                                        .font(.system(size: 11))
                                        .fontWeight(.black)
                                        .foregroundColor(.green)
                                }
                                
                            }
                            
                        }
                    }
                    
                    Divider()
                        .background(.white)
                    
                    // eth
                    VStack{
                        HStack{
                            VStack(alignment: .leading){
                                Text("ADA")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemGray6))
                                
                                Text("Cardano")
                                    .font(.caption)
                                    .foregroundColor(Color(.systemGray3))
                            }
                            
                            
                            Spacer()
                            Text("$0,42")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            // 24h Change
                            VStack{
                                Text("-%0.84")
                                    .font(.system(size: 11))
                                    .fontWeight(.black)
                                    .foregroundColor(.red)
                            }
                            .frame(width: 55)
                            .padding(.vertical, 11)
                            .padding(.horizontal,3)
                            .background(Color(.systemGray6))
                            .cornerRadius(4)
                        }
                        
                    }
                    
                    Divider()
                        .background(.white)
                    
                    // sol
                    VStack{
                        HStack{
                            VStack(alignment: .leading){
                                Text("SOL")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemGray6))
                                
                                Text("Solana")
                                    .font(.caption)
                                    .foregroundColor(Color(.systemGray3))
                            }
                            
                            
                            Spacer()
                            Text("$33,42")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            // 24h Change
                            VStack{
                                Text("+%6.14")
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
                    
                }
                .padding(.horizontal)
                
            }
            
        case .systemSmall:
            ZStack{
                
                LinearGradient(
                    colors: [
                        .purple,
                        .blue
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                
                VStack{
                    HStack{
                        Image(systemName: imageName)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color(.systemGray6))
                        Text("BTC")
                            .fontWeight(.bold)
                            .foregroundColor(Color(.systemGray6))
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
                    Text(price)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
            }
            
        case .systemMedium:
            ZStack{
                
                LinearGradient(
                    colors: [
                        .purple,
                        .blue
                    ],
                    startPoint: .bottomLeading,
                    endPoint: .topTrailing
                )
                VStack(spacing: 4){
                    // btc
                    VStack{
                        HStack{
                            VStack(alignment: .leading){
                                Text("BTC")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemGray6))
                                
                                Text("Bitcoin")
                                    .font(.caption)
                                    .foregroundColor(Color(.systemGray3))
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
                    
                    Divider()
                        .background(.white)
                    
                    // eth
                    VStack{
                        HStack{
                            VStack(alignment: .leading){
                                Text("ETH")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemGray6))
                                
                                Text("Ethereum")
                                    .font(.caption)
                                    .foregroundColor(Color(.systemGray3))
                            }
                            
                            
                            Spacer()
                            Text("$1.314,07")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            // 24h Change
                            VStack{
                                Text("-%1.92")
                                    .font(.system(size: 11))
                                    .fontWeight(.black)
                                    .foregroundColor(.red)
                            }
                            .frame(width: 55)
                            .padding(.vertical, 11)
                            .padding(.horizontal,3)
                            .background(Color(.systemGray6))
                            .cornerRadius(4)
                        }
                        
                    }
                    
                    Divider()
                        .background(.white)
                    
                    HStack{
                        // cake
                        VStack{
                            HStack{
                                VStack(alignment: .leading){
                                    Text("CAKE")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(.systemGray6))
                                    
                                    Text("PancakeSwap")
                                        .font(.caption2)
                                        .foregroundColor(Color(.systemGray3))
                                }
                                
                                
                                Spacer()
                                
                                // price
                                VStack{
                                    Text("$4,72")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    
                                    Text("+%2.14")
                                        .font(.system(size: 11))
                                        .fontWeight(.black)
                                        .foregroundColor(.green)
                                }
                                
                            }
                            
                        }
                        
                        Divider()
                            .background(.white)
                            .frame(height: 50)
                        // srm
                        VStack{
                            HStack{
                                VStack(alignment: .leading){
                                    Text("SRM")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(.systemGray6))
                                    
                                    Text("Serum")
                                        .font(.caption2)
                                        .foregroundColor(Color(.systemGray3))
                                }
                                
                                
                                Spacer()
                                
                                // price
                                VStack{
                                    Text("$0,72")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    
                                    Text("+%0.58")
                                        .font(.system(size: 11))
                                        .fontWeight(.black)
                                        .foregroundColor(.green)
                                }
                                
                            }
                            
                        }
                    }
                    
                    
                }
                .padding(.horizontal)
                
            }
        @unknown default:
            Text("Baris Test")
        }
    }
    
    
}


struct CryptoTrackSwiftUI_iOS_Widget: Widget {
    let kind: String = "CryptoTrackSwiftUI_iOS_Widget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            CryptoTrackSwiftUI_iOS_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("CryptoTrack Widget")
        .description("This is an CryptoTrack widget.")
        .supportedFamilies([.accessoryCircular,
                            .accessoryInline,
                            .accessoryRectangular,
                            .systemExtraLarge,
                            .systemLarge,
                            .systemMedium,
                            .systemSmall
        ])
        
        
        
    }
}



struct CryptoTrackSwiftUI_iOS_Widget_Previews: PreviewProvider {
    static var previews: some View {
        
        /*ActivityConfiguration<ActivityMinimalForDynamicIsland.self>{
            
        }*/
            
        
        CryptoTrackSwiftUI_iOS_WidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
            .previewDisplayName("accessoryCircular")
        
        CryptoTrackSwiftUI_iOS_WidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .accessoryInline))
            .previewDisplayName("accessoryInline")
        
        CryptoTrackSwiftUI_iOS_WidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
            .previewDisplayName("accessoryRectangular")
        
        CryptoTrackSwiftUI_iOS_WidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            .previewDisplayName("systemSmall")
        
        CryptoTrackSwiftUI_iOS_WidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
            .previewDisplayName("systemMedium")
        
        CryptoTrackSwiftUI_iOS_WidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemExtraLarge))
            .previewDisplayName("systemExtraLarge")
        
        
        
    }
}
