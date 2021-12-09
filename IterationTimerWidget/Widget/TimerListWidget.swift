//
//  TimerListWidget.swift
//  TimerListWidget
//
//  Created by hal1437 on 2021/06/09.
//

import WidgetKit
import SwiftUI
import Intents
import IterationTimerUI

struct TimerListProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> TimerListSimpleEntry {
        TimerListSimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (TimerListSimpleEntry) -> ()) {
        let entry = TimerListSimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        let entries = (0 ..< 6)
            .map { $0 * 15 }
            .map { minuteOffset -> TimerListSimpleEntry in
                let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: currentDate)!
                return TimerListSimpleEntry(date: entryDate, configuration: configuration)
            }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct TimerListSimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct TimerListWidgetEntryView : View {
    var entry: TimerListProvider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

struct TimerListWidget: Widget {
    let kind = IterationTimerKind.list.rawValue

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: TimerListProvider()) { entry in
            MultipleTimer()
        }
        .configurationDisplayName("TimerListWidgetName")
        .description("TimerListWidgetDescription")
        .supportedFamilies([.systemMedium, .systemLarge, .systemExtraLarge])
    }
}

struct TimerListWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TimerListWidgetEntryView(entry: TimerListSimpleEntry(date: Date(), configuration: ConfigurationIntent()))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
//            TimerListWidgetEntryView(entry: TimerListSimpleEntry(date: Date(), configuration: ConfigurationIntent()))
//                .previewContext(WidgetPreviewContext(family: .systemMedium))
//
//            TimerListWidgetEntryView(entry: TimerListSimpleEntry(date: Date(), configuration: ConfigurationIntent()))
//                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}

