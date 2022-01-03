//
//  RecentTimer.swift
//  IterationTimerWidget
//
//  Created by hal1437 on 2021/12/18.
//

import IterationTimerCore
import IterationTimerModel
import IterationTimerUI
import SwiftUI
import WidgetKit

struct RecentTimer: View {
    
    let drawable: InstantTimerDrawable?

    init() {
        let dataStore = DataStoreSynchronizer(local: UserDefaults.appGroups, remote: NSUbiquitousKeyValueStore.default)
        let repository = IterationTimerRepository(dataStore: dataStore)
        if let timer = repository.recentTimer {
            self.drawable = InstantDrawable(timer: timer, date: Date())
        } else {
            self.drawable = nil
        }
    }

    init(drawable: InstantTimerDrawable) {
        self.drawable = drawable
    }
    
    var body: some View {
        if let drawable = drawable {
            let percent = CGFloat(min(drawable.currentStamina, drawable.maxStamina)) / CGFloat(drawable.maxStamina)
            ZStack(alignment: .topTrailing) {
                LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color.green, location: 0.0),
                                                          Gradient.Stop(color: Color.green, location: percent),
                                                          Gradient.Stop(color: Color(.systemGray3), location: percent),
                                                          Gradient.Stop(color: Color(.systemGray3), location: 1.0)]),
                               startPoint: .leading,
                               endPoint: .trailing)
                    .opacity(0.6)

                GeometryReader { proxy in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(drawable.title)
                                .font(.caption)
                                .lineLimit(1)
                            
                            Spacer().frame(width: 20)
                        }
                        
                        VStack(alignment: .leading,
                               spacing: 0) {
                            Text("\(min(drawable.currentStamina, drawable.maxStamina))")
                                .font(.largeTitle)
                                .lineLimit(1)
                                .minimumScaleFactor(0.01)

                            Text(" / \(drawable.maxStamina)")
                                .font(.callout)
                                .lineLimit(1)
                                .minimumScaleFactor(0.01)
                        }
                        
                        Spacer()

                        if drawable.currentStamina >= drawable.maxStamina {
                            Text("回復済み").font(.body)
                        } else {
                            Text(drawable.remainingFull.toFormatString()).font(.body)
                        }
                    }
                }.padding()
                
                Image(uiImage: drawable.category.image)
                    .renderingMode(.template)
                    .foregroundColor(Color(.label))
                    .padding()
            }
            .background(Color(.systemGray6))
            .widgetURL(URL(string: "com.hal1437.IterationTimer://?id=\(drawable.id)"))
        } else {
            Text("WidgetTimerNotFound")
                .minimumScaleFactor(0.5)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

private struct Drawable: InstantTimerDrawable {
    var category: TimerCategory = .game
    var id = UUID()
    var title = "InstantTimerDrawable"
    var currentStamina = 120
    var maxStamina = 160
    var remainingFull = TimeInterval(60*60*20)
}

struct RecentTimer_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RecentTimer(drawable: Drawable())
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .environment(\.colorScheme, .light)

            RecentTimer(drawable: Drawable())
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .environment(\.colorScheme, .dark)

        }
    }
}
