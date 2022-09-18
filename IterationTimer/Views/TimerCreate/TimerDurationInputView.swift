//
//  TimerDurationInputView.swift
//  IterationTimer
//
//  Created by hal1437 on 2022/09/18.
//

import SwiftUI

struct TimerDurationInputView: View {
    @Environment(\.dismiss) private var dismiss
    @State var title = ""
    
    var body: some View {
        SingleInputTemplate(title: NSLocalizedString("TimerDurationInputTitle", comment: ""),
                            header: NSLocalizedString("TimerDurationInputHeader", comment: ""),
                            footer: NSLocalizedString("TimerDurationInputFooter", comment: ""),
                            input: TextField(NSLocalizedString("TimerDurationInputPalceholder", comment: ""),
                                             text: $title))
            .navigationBarItems(trailing: NextButton (destination: TimerDivideInputView()))
    }
}

struct TimerDurationInputView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TimerDurationInputView()
        }
    }
}
