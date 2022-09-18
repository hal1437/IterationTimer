//
//  TimerEditView.swift
//  IterationTimer
//
//  Created by hal1437 on 2021/04/26.
//

import SwiftUI
import IterationTimerCore
import IterationTimerUI
import IterationTimerModel
import WidgetKit

struct TimerEditView: View {    
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var viewModel: TimerEditViewModel
    @State private var showingDeleteAlert = false
    
    public init(timer: IterationTimer) {
        let dataStore = DataStoreSynchronizer(local: UserDefaults.appGroups,
                                              remote: NSUbiquitousKeyValueStore.default)
        let storeReview = StoreReviewModel(reviewer: SKStoreReview(),
                                           dataStore: dataStore)
        self.viewModel = TimerEditViewModel(repository: IterationTimerRepository(dataStore: dataStore),
                                            timer: timer,
                                            storeReview: storeReview)
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                TimerCard(drawable: IterationTimerDrawable(timer: viewModel.currentTimer, date: Date())).padding()
                    .background(Color(UIColor.systemGroupedBackground))

                Form {
                    StaminaSettingSection()
                    TimerSettingSection()
                    NotificationSettingSection()
                    DeleteTmerSection()
                }
            }
            .navigationBarTitle(NSLocalizedString("TimerEditTitle", comment: ""), displayMode: .inline)
            .navigationBarItems(leading: Button(LocalizedStringKey("CommonCancel")) { self.presentationMode.wrappedValue.dismiss() },
                                trailing: Button(NSLocalizedString("CommonComplete", comment: "")) {
                                    viewModel.done()
                                    self.presentationMode.wrappedValue.dismiss()
                                    WidgetCenter.shared.reloadAllTimelines()
                                }
            )
        }
    }
    
    @ViewBuilder
    fileprivate func StaminaSettingSection() -> some View {
        Section(header: Text("TimerEditStaminaSection")) {
            HStack {
                Text("TimerEditCurrentValue")
                Spacer()
                StaminaInput(max: Constants.CurrentTimerStaminaMaximum, number: $viewModel.currentStamina)
            }
            
//            StaminaQuickAccessView(text: "クエスト1", count: -30) {
//                print("クエスト1")
//            }
//            StaminaQuickAccessView(text: "クエスト2", count: 60) {
//                print("クエスト2")
//            }
        }
    }
    
    @ViewBuilder
    private func TimerSettingSection() -> some View {
        Section {
            NavigationLink("TimerEditTimerSetting", destination: TimerSettingView(settings: $viewModel.settings)
            )
        }
    }
    
    @ViewBuilder
    private func NotificationSettingSection() -> some View {
        Section {
            NotificationInput(max: viewModel.settings.maxStamina, notification: .constant(.never))
        }
        .disabled(!viewModel.isEnableNotification)
    }

    @ViewBuilder
    fileprivate func DeleteTmerSection() -> some View {
        Section {
            Button("TimerEditDeleteButton", role: .destructive) {
                self.showingDeleteAlert = true
            }
            .actionSheet(isPresented: $showingDeleteAlert) {
                ActionSheet(title: Text("TimerEditDeleteConfirm"), buttons: [
                    .destructive(Text("TimerEditDelete"), action: {
                        viewModel.delete()
                        self.presentationMode.wrappedValue.dismiss()
                    }),
                    .cancel()]
                )
            }
        }
    }

}

struct TimerEditView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TimerEditView(timer: .default)
        }
    }
}
