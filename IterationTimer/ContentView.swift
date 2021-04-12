//
//  ContentView.swift
//  IterationTimer
//
//  Created by hal1437 on 2021/04/07.
//

import SwiftUI
import IterationTimerUI

struct ContentView: View {
    
    private let mock = [Drawable(), Drawable(), Drawable(), Drawable(), Drawable(),
                        Drawable(), Drawable(), Drawable(), Drawable(), Drawable()]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))]) {
                ForEach(mock) {
                    TimerCard(category: .game, title: "SampleTitle", drawable: $0)
                        .padding()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let devices = ["iPhone 8", "iPad Air (4th generation)"]
        ForEach(devices, id: \.self) { device in
            ContentView()
                .previewDevice(.init(rawValue: device))
                .previewDisplayName(device)
        }
    }
}

// FIXME: Mock用構造体
private struct Drawable: TimerDrawable, Identifiable {
    var id = UUID()
    var startTime = Date()
    var currentTime = Date()
    var endTime = Date(timeIntervalSinceNow: TimeInterval(60))
    var duration = TimeInterval(10)
}
