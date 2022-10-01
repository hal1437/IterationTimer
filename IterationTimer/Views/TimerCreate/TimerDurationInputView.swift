//
//  TimerDurationInputView.swift
//  IterationTimer
//
//  Created by hal1437 on 2022/09/18.
//

import SwiftUI
import IterationTimerUI

struct TimerDurationInputView: View {
    @Environment(\.navigationReturner) private var navigationReturner
    @Environment(\.newTimerProperties) private var newTimerProperties
    @State var duration = TimeInterval(60*3)
    
    var body: some View {
        SingleInputTemplate(title: NSLocalizedString("TimerDurationInputTitle", comment: ""),
                            header: NSLocalizedString("TimerDurationInputHeader", comment: ""),
                            footer: NSLocalizedString("TimerDurationInputFooter", comment: ""),
                            input: DurationPicker(maxMinute: 60, duration: $duration))
            .navigationBarItems(trailing: nextButton())
    }

    func nextButton() -> some View {
        var properties = newTimerProperties!
        properties.duration = duration
        return NextButton(destination: TimerDivideInputView()
                                           .environment(\.navigationReturner, navigationReturner)
                                           .environment(\.newTimerProperties, properties))
    }
}

struct TimerDurationInputView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TimerDurationInputView()
        }
    }
}
