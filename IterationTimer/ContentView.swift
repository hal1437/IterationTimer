//
//  ContentView.swift
//  IterationTimer
//
//  Created by hal1437 on 2021/04/07.
//

import SwiftUI
import IterationTimerUI

struct ContentView: View {
    var body: some View {
        TimerCard(category: .game, title: "SampleTitle", drawable: Drawable())
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// FIXME: Mock用構造体
private struct Drawable: TimerDrawable {
    var startTime = Date()
    var currentTime = Date()
    var endTime = Date(timeIntervalSinceNow: TimeInterval(60))
    var duration = TimeInterval(10)
}
