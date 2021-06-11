//
//  IterationTimerWidget.swift
//  IterationTimerWidget
//
//  Created by hal1437 on 2021/06/09.
//

import WidgetKit
import SwiftUI
import Intents
import IterationTimerUI

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

struct IterationTimerWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

@main
struct IterationTimerWidget: Widget {
    let kind: String = "IterationTimerWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            MultipleTimer()
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct IterationTimerWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            IterationTimerWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
//            IterationTimerWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
//                .previewContext(WidgetPreviewContext(family: .systemMedium))
//
//            IterationTimerWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
//                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}

