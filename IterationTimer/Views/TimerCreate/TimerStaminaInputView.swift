//
//  TimerStaminaInputView.swift
//  IterationTimer
//
//  Created by hal1437 on 2022/09/18.
//

import SwiftUI

struct TimerStaminaInputView: View {
    @Environment(\.navigationReturner) private var navigationReturner
    @Environment(\.newTimerProperties) private var newTimerProperties
    @State var text = ""
    
    var body: some View {
        SingleInputTemplate(title: NSLocalizedString("TimerStaminaInputTitle", comment: ""),
                            header: NSLocalizedString("TimerStaminaInputHeader", comment: ""),
                            footer: NSLocalizedString("TimerStaminaInputFooter", comment: ""),
                            input: TextField(NSLocalizedString("TimerStaminaInputPalceholder", comment: ""),
                                             text: $text)
                                       .keyboardType(.numberPad))
            .navigationBarItems(trailing: nextButton())
    }
    
    func nextButton() -> some View {
        var properties = newTimerProperties!
        properties.stamina = Int(text)
        return NextButton(destination: TimerDurationInputView()
                                           .environment(\.navigationReturner, navigationReturner)
                                           .environment(\.newTimerProperties, properties))
                   .disabled(Int(text) == nil)
    }
}

struct TimerStaminaInput_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TimerStaminaInputView()
        }
    }
}
