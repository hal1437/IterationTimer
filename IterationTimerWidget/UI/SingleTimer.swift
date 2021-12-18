//
//  SingleTimer.swift
//  IterationTimerWidget
//
//  Created by hal1437 on 2021/12/18.
//

import IterationTimerCore
import IterationTimerUI
import SwiftUI
import WidgetKit

struct SingleTimer: View {
    
    let drawable: InstantTimerDrawable
    let percent: CGFloat
    
    init(drawable: InstantTimerDrawable) {
        self.drawable = drawable
        percent = CGFloat(min(drawable.currentStamina, drawable.maxStamina)) / CGFloat(drawable.maxStamina)
    }
    
    var body: some View {
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
    }
}

private struct Drawable: InstantTimerDrawable {
    var category: TimerCategory = .game
    var title = "InstantTimerDrawable"
    var currentStamina = 120
    var maxStamina = 160
    var remainingFull = TimeInterval(60*60*20)
}

struct SingleTimer_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SingleTimer(drawable: Drawable())
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .environment(\.colorScheme, .light)

            SingleTimer(drawable: Drawable())
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .environment(\.colorScheme, .dark)

        }
    }
}
