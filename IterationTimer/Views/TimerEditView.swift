//
//  TimerEditView.swift
//  IterationTimer
//
//  Created by hal1437 on 2021/04/26.
//

import SwiftUI
import SwiftUIX
import IterationTimerCore
import IterationTimerUI
import IterationTimerModel
import WidgetKit

struct TimerEditView: View {
    enum Field: CaseIterable, Hashable {
        case timerName
        case currentValue
        case maxValue
        case divideValue
        case duration
    }

    public enum NotificationSelection: CaseIterable {
        case never, on, completion
    }
    
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var viewModel: TimerEditViewModel
    @State private var showingDeleteAlert = false
    @FocusState private var focusedField: Field?
    private var timer: IterationTimer
    
    public init(timer: IterationTimer) {
        self.timer = timer
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
                TimerCard(drawable: IterationTimerDrawable(timer: viewModel.timer, date: Date())).padding()
                    .background(Color(UIColor.systemGroupedBackground))
                Form {
                    Section(header: Text("TimerEditTimerSection")) {
                        TextField("name", text: $viewModel.input.name)
                            .focused($focusedField, equals: .timerName)
                        StaminaQuickAccess(text: "クエスト1", count: -30) {
                            print("クエスト1")
                        }
                        StaminaQuickAccess(text: "クエスト2", count: 60) {
                            print("クエスト2")
                        }
                    }
                    Section(header: Text("TimerEditStaminaSection")) {
                        HStack {
                            Text("TimerEditCurrentValue")
                                .frame(width: 100, alignment: .leading)
                            TextField("0", text: $viewModel.input.currentValue)
                                .keyboardType(.numberPad)
                                .focused($focusedField, equals: .currentValue)
                            Spacer()

                            Button(action: viewModel.divideButtonTapped) {
                                HStack {
                                    Image(systemName: "minus.circle")
                                    Text("\(viewModel.input.divideValue)")
                                }
                            }
                            .buttonStyle(.bordered)
                        }
                        
                        HStack {
                            Text("TimerEditMaxValue")
                                .frame(width: 100, alignment: .leading)
                            TextField("0", text: $viewModel.input.maxValue)
                                .keyboardType(.numberPad)
                                .focused($focusedField, equals: .maxValue)
                        }

                        HStack {
                            Text("TimerEditDuration")
                                .frame(width: 100, alignment: .leading)
                            TextField("0", text: $viewModel.input.duration)
                                .keyboardType(.numberPad)
                                .focused($focusedField, equals: .duration)
                        }
                        HStack {
                            Text("分割値")
                                .frame(width: 100, alignment: .leading)
                            TextField("0", text: $viewModel.input.divideValue)
                                .keyboardType(.numberPad)
                                .focused($focusedField, equals: .divideValue)
                        }
                    }
                    
                    Section(header: Text("TimerEditNotificationSection")) {
                        Picker("TimerEditNotification", selection: $viewModel.input.notification.type) {
                            ForEach(TimerEditViewModel.NotificationSelection.allCases, id: \.self) {
                                Text($0.title)
                            }
                        }

                        switch viewModel.input.notification.type {
                        case .never: EmptyView()
                        case .on:
                            HStack {
                                Text("TimerEditNotificationOn")
                                    .frame(width: 100, alignment: .leading)
                                Spacer()
                                TextField("0", text: $viewModel.input.notification.on)
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.trailing)
                                    .focused($focusedField, equals: .duration)
                            }
                        case .completion:
                            HStack {
                                Text("TimerEditNotificationCompleteBefore")
                                    .frame(width: 100, alignment: .leading)
                                Spacer()
                                TextField("0", text: $viewModel.input.notification.completion)
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.trailing)
                                    .focused($focusedField, equals: .duration)
                            }
                        }
                    }
                    .disabled(!viewModel.isEnableNotification)

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
            .navigationBarTitle(NSLocalizedString("TimerEditTitle", comment: ""), displayMode: .inline)
            .navigationBarItems(leading: Button("CommonCancel") { self.presentationMode.wrappedValue.dismiss() },
                                trailing: Button(NSLocalizedString("CommonComplete", comment: "")) {
                                    viewModel.done()
                                    self.presentationMode.wrappedValue.dismiss()
                                    WidgetCenter.shared.reloadAllTimelines()
                                }
                                .disabled(!viewModel.isEnabled)
            )
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("CommonClose") {
                        focusedField = nil
                    }
                }
            }
        }
    }
}

extension TimerEditViewModel.NotificationSelection {
    var title: String {
        switch self {
        case .never: return NSLocalizedString("TimerEditNotificationSelectionNever", comment: "")
        case .on: return NSLocalizedString("TimerEditNotificationSelectionOn", comment: "")
        case .completion: return NSLocalizedString("TimerEditNotificationSelectionCompletion", comment: "")
        }
    }
}


struct TimerEditView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TimerEditView(timer: IterationTimer(currentStamina: 10, settings: try! .init(title: "NO NAME", category: .game, maxStamina: 10, divideStamina: 10, duration: 10, notification: .never), since: Date()))
        }
    }
}
