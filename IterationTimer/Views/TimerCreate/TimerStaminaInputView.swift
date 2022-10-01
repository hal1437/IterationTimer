//
//  TimerStaminaInputView.swift
//  IterationTimer
//
//  Created by hal1437 on 2022/09/18.
//

import SwiftUI

struct TimerStaminaInputView: View {
    @Environment(\.navigationReturner) private var navigationReturner
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
    
    @ViewBuilder
    func nextButton() -> some View {
        NextButton(destination: TimerDurationInputView()
                                    .environment(\.navigationReturner, navigationReturner))
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
