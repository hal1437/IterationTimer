//
//  TimerCard.swift
//  IterationTimerUI
//
//  Created by hal1437 on 2021/04/07.
//

import SwiftUI

public struct TimerCard: View {
    let category: CardCategory
    let title: String
    let drawable: TimerDrawable
    
    public init(category: CardCategory, title: String, drawable: TimerDrawable) {
        self.category = category
        self.title = title
        self.drawable = drawable
    }
    
    public var body: some View {
        HStack(alignment: .top, spacing: 4) {
            CardIcon(category: category)
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.largeTitle)
                VStack(alignment: .leading, spacing: 4) {
                    ProgressView(value: drawable.progress)
                    HStack(alignment: .bottom) {
                        Spacer()
                        HStack(alignment: .top, spacing: 16) {
                            Text(drawable.remainingUnit)
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
    var remainingUnit: String {
        let delta = endTime.timeIntervalSince(startTime)
        return TimeInterval(Int(delta) % Int(duration)).toFormatString()
    }

    var remainingFull: String {
        return endTime.timeIntervalSince(currentTime).toFormatString()
    }

    var currentUnitCount: Int {
        return Int(currentTime.timeIntervalSince(startTime) / duration)
    }
    var fullUnitCount: Int {
        return Int(endTime.timeIntervalSince(startTime) / duration)
    }

    var progress: Double {
        let delta1 = endTime.timeIntervalSince(startTime)
        let delta2 = endTime.timeIntervalSince(currentTime)
        return 1 - (delta2 / delta1)
    }
}


struct TimerCard_Previews: PreviewProvider {
    static var previews: some View {
        TimerCard(category: .game, title: "SampleTitle", drawable: Drawable())
            .frame(width: nil, height: nil, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

private struct Drawable: TimerDrawable {
    var startTime = Date(timeIntervalSinceNow: TimeInterval(0))
    var currentTime = Date(timeIntervalSinceNow: TimeInterval(31))
    var endTime = Date(timeIntervalSinceNow: TimeInterval(60))
    var duration = TimeInterval(10)
}
