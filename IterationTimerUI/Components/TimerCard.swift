//
//  TimerCard.swift
//  IterationTimerUI
//
//  Created by hal1437 on 2021/04/07.
//

import SwiftUI

public struct TimerCard: View {
    let drawable: TimerDrawable
    
    public init(drawable: TimerDrawable) {
        self.drawable = drawable
    }
    
    public var body: some View {
        HStack(alignment: .top, spacing: 4) {
            CardIcon(category: drawable.category)
            VStack(alignment: .leading, spacing: 8) {
                Text(drawable.title)
                    .font(.largeTitle)
                VStack(alignment: .leading, spacing: 4) {
                    ProgressView(value: drawable.progress)
                    HStack(alignment: .bottom) {
                        Spacer()
                        HStack(alignment: .top, spacing: 16) {
                            Text(drawable.remainingNext)
                                .font(.body)
                            Text(drawable.remainingFull)
                                .font(.body)
                            Text("\(drawable.currentUnitCount)/\(drawable.fullUnitCount)")
                                .font(.body)
                        }
                    }
                }
            }
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

extension TimerDrawable {
    var currentUnitCount: Int {
        if duration == 0 { return 0 }
        return Int(currentTime.timeIntervalSince(startTime) / duration)
    }
    
    var fullUnitCount: Int {
        if duration == 0 { return 0 }
        return Int(endTime.timeIntervalSince(startTime) / duration)
    }
    
    var remainingNext: String {
        if fullUnitCount == 0 { return "" }
        let delta = endTime.timeIntervalSince(startTime)
        let perTime = Int(delta) / fullUnitCount
        let currentInterval = endTime.timeIntervalSince(currentTime)
        return TimeInterval(Int(currentInterval) % perTime).toFormatString()
    }

    var remainingFull: String {
        return endTime.timeIntervalSince(currentTime).toFormatString()
    }

    var progress: Double {
        let delta1 = endTime.timeIntervalSince(startTime)
        let delta2 = endTime.timeIntervalSince(currentTime)
        return 1 - (delta2 / delta1)
    }
}


struct TimerCard_Previews: PreviewProvider {
    static var previews: some View {
        TimerCard(drawable: Drawable())
            .frame(width: nil, height: nil, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

private struct Drawable: TimerDrawable {
    var category: CardCategory = .game
    var title = "SampleTitle"
    var startTime = Date(timeIntervalSinceNow: TimeInterval(0))
    var currentTime = Date(timeIntervalSinceNow: TimeInterval(31))
    var endTime = Date(timeIntervalSinceNow: TimeInterval(60))
    var duration = TimeInterval(10)
}
