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
                    .font(.headline)
                VStack(alignment: .leading, spacing: 4) {
                    DividedProgressBar(currentValue: drawable.currentStamina, maxValue: drawable.maxStamina, divideValue: drawable.divideStamina)
                    HStack(alignment: .bottom) {
                        HStack(alignment: .top, spacing: 16) {
                            Text("\(min(drawable.currentStamina, drawable.maxStamina))/\(drawable.maxStamina)").font(.body)
                            Spacer()
                            if drawable.currentStamina >= drawable.maxStamina {
                                Text("回復済み").font(.body)
                            } else {
                                Text(drawable.remainingFull.toFormatString()).font(.body)
                            }
                        }
                    }
                }
            }
        }
        .padding(8)
        .background(Color.secondarySystemBackground)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct TimerCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TimerCard(drawable: Drawable())
            
            TimerCard(drawable: Drawable())
                .environment(\.colorScheme, .dark)
        }
        .frame(width: nil, height: nil, alignment: .center)
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

private struct Drawable: TimerDrawable {
    var category: TimerCategory = .game
    var title = "SampleTitle"
    var currentStamina = 50
    var maxStamina = 100
    var divideStamina = 40
    var remainingOne = TimeInterval(10)
    var remainingFull = TimeInterval(500)
}
