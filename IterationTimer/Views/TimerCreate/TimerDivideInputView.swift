//
//  TimerDivideInputView.swift
//  IterationTimer
//
//  Created by hal1437 on 2022/09/18.
//

import SwiftUI

struct TimerDivideInputView: View {
    @Environment(\.navigationReturner) private var navigationReturner
    @Environment(\.newTimerProperties) private var newTimerProperties
    @State var text = ""
    
    var body: some View {
        SingleInputTemplate(title: NSLocalizedString("TimerDivideInputTitle", comment: ""),
                            header: NSLocalizedString("TimerDivideInputHeader", comment: ""),
                            footer: NSLocalizedString("TimerDivideInputFooter", comment: ""),
                            input: TextField(NSLocalizedString("TimerDivideInputPalceholder", comment: ""),
                                             text: $text)
                                       .keyboardType(.numberPad))
            .navigationBarItems(trailing: nextButton())
    }

    func nextButton() -> some View {
        var properties = newTimerProperties!
        properties.divide = Int(text)
        return NextButton(destination: TimerCreateConfirmView()
                                           .environment(\.navigationReturner, navigationReturner)
                                           .environment(\.newTimerProperties, properties))
                   .disabled(Int(text) == nil)
    }
}

struct TimerDivideInputView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TimerDivideInputView()
        }
    }
}
