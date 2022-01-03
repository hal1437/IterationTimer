//
//  TimerListWidgetTimelineProvider.swift
//  IterationTimerWidget
//
//  Created by hal1437 on 2021/12/28.
//

import IterationTimerModel
import WidgetKit

struct TimerListWidgetTimelineProvider: IntentTimelineProvider {
    let repository: IterationTimerRepositoryProtocol
    
    func placeholder(in context: Context) -> IntentTimelineEntry {
        IntentTimelineEntry(date: Date(), configuration: ConfigurationIntent(), relevance: nil)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (IntentTimelineEntry) -> ()) {
        completion(placeholder(in: context))
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<IntentTimelineEntry>) -> ()) {
        let currentDate = Date()
        let timers = repository.getTimers
        guard !timers.isEmpty else {
            let currentEntry = IntentTimelineEntry(date: currentDate, configuration: configuration, relevance: nil)
            completion(Timeline(entries: [currentEntry], policy: .never))
            return
        }
        
        let entries = (0 ..< 6)
            .map { $0 * 15 }
            .map { minuteOffset -> IntentTimelineEntry in
                let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: currentDate)!
                let total = timers.map { $0.relevance(date: entryDate).score }.reduce(0, +)
                return IntentTimelineEntry(date: entryDate, configuration: configuration, relevance: .init(score: total))
            }

        completion(Timeline(entries: entries, policy: .atEnd))
    }
}
