//
//  TimerCreateConfirmView.swift
//  IterationTimer
//
//  Created by hal1437 on 2022/09/18.
//

import SwiftUI
import IterationTimerUI
import IterationTimerModel

struct TimerCreateConfirmView: View {
    @Environment(\.navigationReturner) var navigationReturner
    @Environment(\.newTimerProperties) private var newTimerProperties
    @ObservedObject var viewModel = TimerCreateConfirmViewModel(repository: WidgetUpdateIterationTimerRepository(dataStore: DataStoreSynchronizer(local: UserDefaults.appGroups, remote: NSUbiquitousKeyValueStore.default)))

    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                Text(NSLocalizedString("TimerCreateConfirmDescription", comment: ""))
                    .font(.body)
                    .foregroundColor(.primary)
                TimerCard(drawable: IterationTimerDrawable(timer: timer(), date: Date()) )
                    .background(Color(UIColor.systemGroupedBackground))
                
                Spacer()
            }.padding(.horizontal, 20)
        }
        .navigationTitle(NSLocalizedString("TimerCreateConfirmTitle", comment: ""))
        .navigationBarItems(trailing: CompleteButton {
            self.viewModel.addTimer(timer: timer())
        })
        .onChange(of: viewModel.done) { done in
            if done {
                self.navigationReturner?()
            }
        }
    }
    
    func timer() -> IterationTimer {
        .init(currentStamina: newTimerProperties!.stamina!,
                                            settings: try! .init(title: newTimerProperties!.title!,
                                                                 category: .game,
                                                                 maxStamina: newTimerProperties!.stamina!,
                                                                 divideStamina: newTimerProperties!.divide!,
                                                                 duration: newTimerProperties!.duration!,
                                                                 notification: .never),
                                            since: Date())
    }
}

struct TimerCreateConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TimerCreateConfirmView()
        }
    }
}
