//
//  InstantTimer.swift
//  IterationTimerWidget
//
//  Created by hal1437 on 2021/06/10.
//

import IterationTimerCore
import IterationTimerUI
import SwiftUI
import WidgetKit

public struct InstantTimer: View {
    @Environment(\.widgetFamily) var family
    let drawable: InstantTimerDrawable
    
    public init(drawable: InstantTimerDrawable) {
        self.drawable = drawable
    }

    public var body: some View {
        HStack(alignment: .center, spacing: 4) {
            if family != .systemSmall {
                Image(uiImage: drawable.category.image)
                    .renderingMode(.template)
                    .foregroundColor(Color(.label))
            }
            VStack(alignment: .trailing, spacing: 4) {
                HStack {
                    Text(drawable.title)
                        .font(.caption)
                        .lineLimit(1)
                        .layoutPriority(0)

                    Spacer()

                    Text("\(drawable.currentStamina)/\(drawable.maxStamina)")
                        .font(.caption)
                        .lineLimit(1)
                        .allowsTightening(true)
                        .layoutPriority(1)
                }

                CustomProgressView(progress: CGFloat(drawable.currentStamina) / CGFloat(drawable.maxStamina))
                
                Spacer()

                if drawable.currentStamina >= drawable.maxStamina {
                    Text("TimerComplete")
                        .font(.caption)
                        .minimumScaleFactor(0.5)
                        .layoutPriority(1)

                } else {
                    Text(Date() + drawable.remainingFull, style: .relative)
                        .multilineTextAlignment(.trailing)
                        .font(.caption)
                }
            }
        }
        .padding(8)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct CustomProgressView: View {
    var progress: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().fill(Color(UIColor.lightGray))
                Rectangle().fill(Color.blue)
                    .frame(width: geometry.size.width * progress)
            }
        }
        .cornerRadius(2.5)
        .frame(height: 5)
    }
}

struct InstantTimer_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            InstantTimer(drawable: Drawable())
                .previewContext(WidgetPreviewContext(family: .systemSmall))

            InstantTimer(drawable: Drawable())
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
        .padding()
    }
}

private struct Drawable: InstantTimerDrawable {
    var category: TimerCategory = .game
    var id = UUID()
    var title = "SampleTitleSampleTitle"
    var currentStamina = 100
    var maxStamina = 100
    var remainingFull =  TimeInterval(60)
}
