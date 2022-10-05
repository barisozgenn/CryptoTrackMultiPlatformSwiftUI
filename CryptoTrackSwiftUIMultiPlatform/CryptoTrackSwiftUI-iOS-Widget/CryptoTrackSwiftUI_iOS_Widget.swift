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
    var entry: Provider.Entry

    var body: some View {
        
        switch widgetFamily {
        case .accessoryInline:
            HStack(spacing: 2){
                Image(systemName: "bitcoinsign.circle.fill")
                     .resizable()
                     .scaledToFit()
                Text("$20,297.92")
                    .fontWeight(.semibold)
                    .font(.system(size: 16))
            }
            .foregroundColor(.green)
            .frame(width: .infinity, height: 30)
        case .accessoryCircular:
            Gauge(value: 0.5729){
                VStack(spacing: 2){
                    Image(systemName: "bitcoinsign.circle.fill")
                         .resizable()
                         .scaledToFit()
                    Text("$20.297")
                        .fontWeight(.semibold)
                        .font(.system(size: 8))
                    Text("+%7.29")
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
                    Image(systemName: "bitcoinsign.circle.fill")
                         .resizable()
                         .scaledToFit()
                    Spacer()
                    VStack(alignment: .trailing){
                        Text("$20,297.92")
                            .fontWeight(.semibold)
                            .font(.system(size: 16))
                        Text("+%7.29")
                            .fontWeight(.bold)
                            .font(.system(size: 12))
                    }
                }
                .foregroundColor(.green)
                .frame(width: .infinity, height: 30)
            }
            .gaugeStyle(.linearCapacity)
            .foregroundColor(.green)
        case .systemExtraLarge:
            Text("Bitcoin")
        case .systemMedium:
            Text("Bitcoin")
        case .systemSmall:
            Text("Bitcoin")
        case .systemLarge:
            Text("Bitcoin")
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
                            .systemMedium,
                            .systemSmall
                           ])
    }
}

struct CryptoTrackSwiftUI_iOS_Widget_Previews: PreviewProvider {
    static var previews: some View {
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
