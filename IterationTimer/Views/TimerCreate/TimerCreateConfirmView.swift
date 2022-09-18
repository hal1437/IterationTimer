//
//  TimerCreateConfirmView.swift
//  IterationTimer
//
//  Created by hal1437 on 2022/09/18.
//

import SwiftUI
import IterationTimerUI

struct TimerCreateConfirmView: View {
    @Environment(\.navigationReturner) var navigationReturner

    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                Text(NSLocalizedString("TimerCreateConfirmDescription", comment: ""))
                    .font(.body)
                    .foregroundColor(.primary)
                TimerCard(drawable: IterationTimerDrawable(timer: .default, date: Date()))
                    .background(Color(UIColor.systemGroupedBackground))
                
                Spacer()
            }.padding(.horizontal, 20)
        }
        .navigationTitle(NSLocalizedString("TimerCreateConfirmTitle", comment: ""))
        .navigationBarItems(trailing: CompleteButton {
            self.navigationReturner?()
        })
    }
}

struct TimerCreateConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TimerCreateConfirmView()
        }
    }
}
