//
//  AlmostAlwaysProvider.swift
//  IterationTimerWidget
//
//  Created by hal1437 on 2021/12/10.
//

import WidgetKit

struct AlmostAlwaysProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> IntentTimelineEntry {
        IntentTimelineEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (IntentTimelineEntry) -> ()) {
        completion(placeholder(in: context))
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<IntentTimelineEntry>) -> ()) {
        completion(Timeline<IntentTimelineEntry>.almostAlways(from: Date(), with: configuration))
    }
}
