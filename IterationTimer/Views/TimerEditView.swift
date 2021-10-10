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
    enum Field: CaseIterable, Hashable {
        case timerName
        case currentValue
        case maxValue
        case duration
    }
    
    enum Mode {
        case add
        case edit(timer: IterationTimer)
    }
    
    public enum NotificationSelection: CaseIterable {
        case never, on, completion
    }
    
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var viewModel: TimerEditViewModel
    @State private var showingDeleteAlert = false
    @FocusState private var focusedField: Field?
    private var mode: Mode
    
    public init(mode: Mode) {
        self.mode = mode
        self.viewModel = TimerEditViewModel(repository: IterationTimerRepository(userDefaults: .appGroups), mode: mode)
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                TimerCard(drawable: IterationTimerDrawable(timer: viewModel.timer, date: Date())).padding()
                    .background(Color(UIColor.systemGroupedBackground))
                Form {
                    Section(header: Text("タイマー名")) {
                        TextField("name", text: $viewModel.input.name)
                            .focused($focusedField, equals: .timerName)
                    }
                    Section(header: Text("スタミナの設定")) {
                        if mode.isEdit {
                            HStack {
                                Text("現在値")
                                    .frame(width: 100, alignment: .leading)
                                TextField("0", text: $viewModel.input.currentValue)
                                    .keyboardType(.numberPad)
                                    .focused($focusedField, equals: .timerName)
                            }
                        }
                        
                        HStack {
                            Text("最大値")
                                .frame(width: 100, alignment: .leading)
                            TextField("0", text: $viewModel.input.maxValue)
                                .keyboardType(.numberPad)
                                .focused($focusedField, equals: .maxValue)
                        }

                        HStack {
                            Text("1単位の時間")
                                .frame(width: 100, alignment: .leading)
                            TextField("0", text: $viewModel.input.duration)
                                .keyboardType(.numberPad)
                                .focused($focusedField, equals: .duration)
                        }
                    }
                    
                    Section(header: Text("通知設定")) {
                        Picker("通知", selection: $viewModel.input.notification.type) {
                            ForEach(TimerEditViewModel.NotificationSelection.allCases, id: \.self) {
                                Text($0.title)
                            }
                        }

                        switch viewModel.input.notification.type {
                        case .never: EmptyView()
                        case .on:
                            HStack {
                                Text("通知する値")
                                    .frame(width: 100, alignment: .leading)
                                Spacer()
                                TextField("0", text: $viewModel.input.notification.on)
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.trailing)
                                    .focused($focusedField, equals: .duration)
                            }
                        case .completion:
                            HStack {
                                Text("事前に通知する秒数")
                                    .frame(width: 100, alignment: .leading)
                                Spacer()
                                TextField("0", text: $viewModel.input.notification.completion)
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.trailing)
                                    .focused($focusedField, equals: .duration)
                            }
                        }
                    }

                    Section {
                        if mode.isEdit {
                            Button("タイマーを削除する") {
                                self.showingDeleteAlert = true
                            }
                            .actionSheet(isPresented: $showingDeleteAlert) {
                                ActionSheet(title: Text("データが削除されますがよろしいですか？"), buttons: [
                                    .destructive(Text("削除する"), action: {
                                          viewModel.delete()
                                          self.presentationMode.wrappedValue.dismiss()
                                    }),
                                    .cancel()]
                                )
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(mode.title, displayMode: .inline)
            .navigationBarItems(leading: Button("キャンセル") { self.presentationMode.wrappedValue.dismiss() },
                                trailing: Button(mode.doneButton) {
                                    viewModel.done()
                                    self.presentationMode.wrappedValue.dismiss()
                                    WidgetCenter.shared.reloadAllTimelines()
                                }
                                .disabled(!viewModel.isEnabled)
            )
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("閉じる") {
                        focusedField = nil
                    }
                }
            }
        }
    }
}

private extension TimerEditView.Mode {
    var title: String {
        switch self {
        case .add: return "タイマーの追加"
        case .edit(_): return "タイマーの編集"
        }
    }

    var doneButton: String {
        switch self {
        case .add: return "追加"
        case .edit(_): return "完了"
        }
    }
    
    var isEdit: Bool {
        switch self {
        case .add: return false
        case .edit(_): return true
        }
    }
}

extension TimerEditViewModel.NotificationSelection {
    var title: String {
        switch self {
        case .never: return "通知しない"
        case .on: return "特定の値の時に通知"
        case .completion: return "回復前に通知"
        }
    }
}


struct TimerEditView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TimerEditView(mode: .add)
            TimerEditView(mode: .edit(timer: IterationTimer(currentStamina: 10, settings: try! .init(title: "NO NAME", category: .game, maxStamina: 10, duration: 10, notification: .never), since: Date())))
        }
    }
}
