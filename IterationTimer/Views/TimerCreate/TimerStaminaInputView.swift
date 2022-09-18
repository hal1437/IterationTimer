//
//  TimerStaminaInputView.swift
//  IterationTimer
//
//  Created by hal1437 on 2022/09/18.
//

import SwiftUI

struct TimerStaminaInputView: View {
    @Environment(\.navigationReturner) private var navigationReturner
    @State var title = ""
    
    var body: some View {
        SingleInputTemplate(title: NSLocalizedString("TimerStaminaInputTitle", comment: ""),
                            header: NSLocalizedString("TimerStaminaInputHeader", comment: ""),
                            footer: NSLocalizedString("TimerStaminaInputFooter", comment: ""),
                            input: TextField(NSLocalizedString("TimerStaminaInputPalceholder", comment: ""),
                                             text: $title))
            .navigationBarItems(trailing: NextButton (destination: TimerDurationInputView().environment(\.navigationReturner, navigationReturner)))
    }
}

struct TimerStaminaInput_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TimerStaminaInputView()
        }
    }
}
