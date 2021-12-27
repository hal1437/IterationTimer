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
    @ObservedObject var viewModel = MultipleTimerViewModel(repository: IterationTimerRepository(dataStore: DataStoreSynchronizer(local: UserDefaults.appGroups, remote: NSUbiquitousKeyValueStore.default)))
    private let drawable = Drawable()
    private let spacing = CGFloat(8)
    
    var body: some View {
        GeometryReader { geometry in
            LazyVGrid(columns: Array(repeating: GridItem(), count: family.contents.columns), spacing: spacing) {
                if viewModel.timers.isEmpty {
                    Text("タイマーがありません")
                        .font(.caption)
                        .foregroundColor(.gray)
                } else {
                    ForEach(viewModel.timers.prefix(family.contents.rows * family.contents.columns)) { timer in
                        let height = CGFloat((Int(geometry.size.height) - Int(spacing) * (family.contents.rows - 1)) / family.contents.rows)
                        
                        Link(destination: URL(string: "com.hal1437.IterationTimer://?id=\(timer.id)")!, label: {
                            InstantTimer(drawable: InstantDrawable(timer: timer, date: Date()))
                                .frame(width: nil, height: height, alignment: .center)
                        })
                    }
                    Spacer()
                }
            }
        }.padding(10)
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

struct InstantDrawable: InstantTimerDrawable {
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
    var contents: (rows: Int, columns: Int) {
        switch self {
        case .systemSmall: return (2, 1)
        case .systemMedium: return (2, 2)
        case .systemLarge: return (5, 2)
        case .systemExtraLarge:  return (4, 4)
        @unknown default:
            return (2, 1)
        }
    }
}
