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
    @Environment(\.newTimerProperties) private var newTimerProperties

    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                Text(NSLocalizedString("TimerCreateConfirmDescription", comment: ""))
                    .font(.body)
                    .foregroundColor(.primary)
                TimerCard(drawable: drawable())
                    .background(Color(UIColor.systemGroupedBackground))
                
                Spacer()
            }.padding(.horizontal, 20)
        }
        .navigationTitle(NSLocalizedString("TimerCreateConfirmTitle", comment: ""))
        .navigationBarItems(trailing: CompleteButton {
            self.navigationReturner?()
        })
    }
    
    func drawable() -> IterationTimerDrawable {
        IterationTimerDrawable(timer: .init(currentStamina: newTimerProperties!.stamina!,
                                            settings: try! .init(title: newTimerProperties!.title!,
                                                                 category: .game,
                                                                 maxStamina: newTimerProperties!.stamina!,
                                                                 divideStamina: newTimerProperties!.divide!,
                                                                 duration: newTimerProperties!.duration!,
                                                                 notification: .never),
                                            since: Date()),
                               date: Date())
    }
}

struct TimerCreateConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TimerCreateConfirmView()
        }
    }
}
