//
//  TimerDurationInputView.swift
//  IterationTimer
//
//  Created by hal1437 on 2022/09/18.
//

import SwiftUI

struct TimerDurationInputView: View {
    @Environment(\.navigationReturner) private var navigationReturner
    @Environment(\.newTimerProperties) private var newTimerProperties
    @State var text = ""
    
    var body: some View {
        SingleInputTemplate(title: NSLocalizedString("TimerDurationInputTitle", comment: ""),
                            header: NSLocalizedString("TimerDurationInputHeader", comment: ""),
                            footer: NSLocalizedString("TimerDurationInputFooter", comment: ""),
                            input: TextField(NSLocalizedString("TimerDurationInputPalceholder", comment: ""),
                                             text: $text)
                                       .keyboardType(.numberPad))
            .navigationBarItems(trailing: nextButton())
    }

    func nextButton() -> some View {
        var properties = newTimerProperties!
        properties.duration = TimeInterval(text)
        return NextButton(destination: TimerDivideInputView()
                                           .environment(\.navigationReturner, navigationReturner)
                                           .environment(\.newTimerProperties, properties))
                   .disabled(TimeInterval(text) == nil)
    }
}

struct TimerDurationInputView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TimerDurationInputView()
        }
    }
}
