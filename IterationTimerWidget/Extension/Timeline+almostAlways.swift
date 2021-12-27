//
//  Timeline+almostAlways.swift
//  IterationTimerWidget
//
//  Created by hal1437 on 2021/12/10.
//

import WidgetKit

extension Timeline where EntryType == IntentTimelineEntry {
    static func almostAlways(from date: Date, with configuration: ConfigurationIntent) -> Timeline {
        let entries = (0 ..< 6)
            .map { $0 * 15 }
            .map { minuteOffset -> IntentTimelineEntry in
                let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: date)!
                return IntentTimelineEntry(date: entryDate, configuration: configuration)
            }

        return Timeline(entries: entries, policy: .atEnd)
    }
}
