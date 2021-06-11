//
//  MultipleTimer.swift
//  IterationTimerUI
//
//  Created by hal1437 on 2021/06/10.
//

import SwiftUI
import WidgetKit
import IterationTimerUI

struct MultipleTimer: View {
    
    private let drawable = Drawable()
    
    var body: some View {
        VStack {
            InstantTimer(drawable: Drawable())
            InstantTimer(drawable: Drawable())
            InstantTimer(drawable: Drawable())
        }.padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
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
}
