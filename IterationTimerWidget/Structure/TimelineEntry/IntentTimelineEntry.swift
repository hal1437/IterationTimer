//
//  IntentTimelineEntry.swift
//  IterationTimerWidget
//
//  Created by hal1437 on 2021/12/10.
//

import WidgetKit

struct IntentTimelineEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let relevance: TimelineEntryRelevance?
}
