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
                    ProgressView(value: Double(drawable.currentStamina), total: Double(drawable.maxStamina))
                    HStack(alignment: .bottom) {
                        Spacer()
                        HStack(alignment: .top, spacing: 16) {
                            if drawable.currentStamina >= drawable.maxStamina {
                                Text("回復済み").font(.body)
                            } else {
                                Text("\(Int(drawable.remainingOne))秒").font(.body)
                                Text("\(Int(drawable.remainingFull))秒").font(.body)
                            }
                            Text("\(min(drawable.currentStamina, drawable.maxStamina))/\(drawable.maxStamina)").font(.body)
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

struct TimerCard_Previews: PreviewProvider {
    static var previews: some View {
        TimerCard(drawable: Drawable())
            .frame(width: nil, height: nil, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

private struct Drawable: TimerDrawable {
    var category: TimerCategory = .game
    var title = "SampleTitle"
    var currentStamina = 50
    var maxStamina = 100
    var remainingOne = TimeInterval(10)
    var remainingFull = TimeInterval(500)
}
