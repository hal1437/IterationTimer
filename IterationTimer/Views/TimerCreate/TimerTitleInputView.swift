//
//  TimerTitleInputView.swift
//  IterationTimer
//
//  Created by hal1437 on 2022/09/18.
//

import SwiftUI

struct TimerTitleInputView: View {
    @Environment(\.dismiss) private var dismiss
    @State var title = ""
    
    var body: some View {
        SingleInputTemplate(title: NSLocalizedString("TimerTitleInputTitle", comment: ""),
                            header: NSLocalizedString("TimerTitleInputHeader", comment: ""),
                            footer: NSLocalizedString("TimerTitleInputFooter", comment: ""),
                            input: TextField(NSLocalizedString("TimerTitleInputPalceholder", comment: ""),
                                             text: $title)
                                       .keyboardType(.default))
            .navigationBarItems(leading: CancelButton {
                self.dismiss()
            }, trailing: nextButton())
    }

    @ViewBuilder
    func nextButton() -> some View {
        NextButton(destination: TimerStaminaInputView()
                                    .environment(\.navigationReturner, dismiss))
        .disabled(title.isEmpty)
    }

}

struct TimerTitleInput_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TimerTitleInputView()
        }
    }
}
