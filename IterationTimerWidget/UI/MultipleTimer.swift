//
//  MultipleTimer.swift
//  IterationTimerUI
//
//  Created by hal1437 on 2021/06/10.
//

import SwiftUI
import WidgetKit
import IterationTimerModel
import IterationTimerUI

struct MultipleTimer: View {
    @Environment(\.widgetFamily) var family
    @ObservedObject var viewModel = MultipleTimerViewModel(repository: IterationTimerRepository(userDefaults: .appGroups))
    private let drawable = Drawable()
    
    var body: some View {
        VStack {
            ForEach(viewModel.timers.prefix(family.counts)) { timer in
                InstantTimer(drawable: InstantDrawable(timer: timer, date: Date()))
            }
        }.padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}

struct MultipleTimer_Previews: PreviewProvider {
    static var previews: some View {
        MultipleTimer()
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

private struct Drawable: InstantTimerDrawable {
    var category: TimerCategory = .game
    var title = "Game"
    var currentStamina = 50
    var maxStamina = 100
    var remainingFull =  TimeInterval(50*60)
}

private struct InstantDrawable: InstantTimerDrawable {
    private var timer: IterationTimer
    private var date: Date
    init(timer: IterationTimer, date: Date) {
        self.timer = timer
        self.date = date
    }
    
    var category: TimerCategory { timer.settings.category }
    var title: String { timer.settings.title }
    var currentStamina: Int { timer.currentStamina(date: date) }
    var maxStamina: Int { timer.settings.maxStamina }
    var remainingOne: TimeInterval { timer.remainingOne(date: date) }
    var remainingFull: TimeInterval { timer.remainingFull(date: date) }
}

private extension WidgetFamily {
    var counts: Int {
        switch self {
        case .systemSmall, .systemMedium: return 3
        case .systemLarge: return 8
        @unknown default:
            return 8
        }
    }
}
