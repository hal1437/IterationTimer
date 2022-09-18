//
//  TimerDivideInputView.swift
//  IterationTimer
//
//  Created by hal1437 on 2022/09/18.
//

import SwiftUI

struct TimerDivideInputView: View {
    @Environment(\.dismiss) private var dismiss
    @State var title = ""
    
    var body: some View {
        SingleInputTemplate(title: NSLocalizedString("TimerDivideInputTitle", comment: ""),
                            header: NSLocalizedString("TimerDivideInputHeader", comment: ""),
                            footer: NSLocalizedString("TimerDivideInputFooter", comment: ""),
                            input: TextField(NSLocalizedString("TimerDivideInputPalceholder", comment: ""),
                                             text: $title))
            .navigationBarItems(trailing: NextButton (destination: TimerCreateConfirmView()))
    }
}

struct TimerDivideInputView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TimerDivideInputView()
        }
    }
}
