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
    
    @ObservedObject var viewModel = MultipleTimerViewModel(repository: IterationTimerRepository(userDefaults: .standard))
    private let drawable = Drawable()
    
    var body: some View {
        VStack {
            ForEach(viewModel.timers) { timer in
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
