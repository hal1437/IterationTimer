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
            completion(Timeline(entries: [], policy: .never))
            return
        }
        
        let remainingFull = max(timers.map { $0.remainingFull(date: currentDate) }.max()!, 0)
        let refreshTimes = Int(remainingFull / 60)
        let entries = (0 ..< refreshTimes)
            .map { minuteOffset -> IntentTimelineEntry in
                let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: currentDate)!
                let total = timers.map { $0.relevance(date: entryDate).score }.reduce(0, +)
                return IntentTimelineEntry(date: entryDate, configuration: configuration, relevance: .init(score: total))
            }
        
        completion(Timeline(entries: entries, policy: .atEnd))
    }
}
