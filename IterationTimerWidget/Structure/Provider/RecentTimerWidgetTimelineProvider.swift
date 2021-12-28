//
//  RecentTimerWidgetTimelineProvider.swift
//  IterationTimerWidget
//
//  Created by hal1437 on 2021/12/28.
//

import IterationTimerModel
import WidgetKit

struct RecentTimerWidgetTimelineProvider: IntentTimelineProvider {
    let repository: IterationTimerRepositoryProtocol
    
    func placeholder(in context: Context) -> IntentTimelineEntry {
        IntentTimelineEntry(date: Date(), configuration: ConfigurationIntent(), relevance: nil)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (IntentTimelineEntry) -> ()) {
        completion(placeholder(in: context))
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<IntentTimelineEntry>) -> ()) {
        let currentDate = Date()
        
        guard let timer = repository.recentTimer else {
            completion(Timeline(entries: [], policy: .never))
            return
        }

        let remainingFull = max(timer.remainingFull(date: currentDate), 0)
        let refreshTimes = Int(remainingFull / 60)
        let entries = (0 ..< refreshTimes)
            .map { minuteOffset -> IntentTimelineEntry in
                let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: currentDate)!
                return IntentTimelineEntry(date: entryDate, configuration: configuration, relevance: timer.relevance(date: entryDate))
            }
        
        completion(Timeline(entries: entries, policy: .atEnd))
    }
}
