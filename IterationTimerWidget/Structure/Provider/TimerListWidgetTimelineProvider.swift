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
        let timers = repository.getTimers
        let creator = WidgetUpdateTimeCreator(repository: repository)
        let updateDates = creator.create(currentDate: Date())
        
        let entries = updateDates.map { entryDate -> IntentTimelineEntry in
            let total = timers.map { $0.relevance(date: entryDate).score }.reduce(0, +)
            return IntentTimelineEntry(date: entryDate, configuration: configuration, relevance: .init(score: total))
        }

        if updateDates.count == 1 {
            completion(Timeline(entries: entries, policy: .never))
        } else {
            completion(Timeline(entries: entries, policy: .atEnd))
        }
    }
}
