//
//  InstantTimer.swift
//  IterationTimerUI
//
//  Created by hal1437 on 2021/06/10.
//

import SwiftUI

public struct InstantTimer: View {
    let drawable: InstantTimerDrawable
    
    public init(drawable: InstantTimerDrawable) {
        self.drawable = drawable
    }

    public var body: some View {
        HStack(alignment: .center, spacing: 4) {
            Image(uiImage: drawable.category.image)
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(drawable.title)
                        .font(.body)
                        .lineLimit(1)
                    Spacer()
                    Text("\(drawable.currentStamina)/\(drawable.maxStamina)")
                        .font(.caption)
                        .lineLimit(1)
                        .allowsTightening(true)
                }
                
                CustomProgressView(progress: CGFloat(drawable.currentStamina) / CGFloat(drawable.maxStamina))
            }
        }
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
        InstantTimer(drawable: Drawable())
            .frame(width: 146, height: 146, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .previewLayout(.sizeThatFits)
    }
}

private struct Drawable: InstantTimerDrawable {
    var category: TimerCategory = .game
    var title = "SampleTitleSampleTitle"
    var currentStamina = 33
    var maxStamina = 100
}
