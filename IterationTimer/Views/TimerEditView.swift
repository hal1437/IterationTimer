//
//  TimerEditView.swift
//  IterationTimer
//
//  Created by hal1437 on 2021/04/26.
//

import SwiftUI
import IterationTimerUI
import IterationTimerModel

struct TimerEditView: View {
    enum Mode {
        case add
        case edit(timer: IterationTimer)
    }
    
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var viewModel: TimerEditViewModel
    @State private var showingDeleteAlert = false
    private var mode: Mode
    
    public init(mode: Mode) {
        self.mode = mode
        self.viewModel = TimerEditViewModel(repository: IterationTimerRepository(userDefaults: .standard), mode: mode)
    }

    var body: some View {
        NavigationView {
            VStack {
                TimerCard(drawable: IterationTimerDrawable(timer: viewModel.timer, date: Date()))
                    .padding()

                Divider()
                
                ScrollView {
                    VStack {
                        HorizontalInput(title: "名前", contents: TextInput(placeholder: "名前", text: $viewModel.name))
                        Divider()
                        if mode.isEdit {
                            HorizontalInput(title: "現在値", contents: NumberInput(text: $viewModel.currentValue))
                            Divider()
                        }
                        HorizontalInput(title: "最大値", contents: NumberInput(text: $viewModel.maxValue))
                        Divider()
                        HorizontalInput(title: "1単位が回復するまでの秒数", contents: NumberInput(text: $viewModel.duration))
                        Divider()
                        if mode.isEdit {
                            Button("タイマーを削除する") {
                                self.showingDeleteAlert = true
                            }
                                .alert(isPresented: $showingDeleteAlert) {
                                    Alert(title: Text("警告"),
                                          message: Text("データが削除されますがよろしいですか？"),
                                          primaryButton: .cancel(Text("キャンセル")),    // キャンセル用
                                          secondaryButton: .destructive(Text("削除"), action: {
                                                viewModel.delete()
                                                self.presentationMode.wrappedValue.dismiss()
                                          }))   // 破壊的変更用
                                }
                                .padding()
                            Divider()
                        }
                    }
                }
            }
            .navigationBarTitle(mode.title, displayMode: .inline)
            .navigationBarItems(leading: Button("キャンセル") { self.presentationMode.wrappedValue.dismiss() },
                                trailing: Button(mode.doneButton) {
                                    viewModel.done()
                                    self.presentationMode.wrappedValue.dismiss()
                                })
        }
    }
}

extension TimerEditView.Mode {
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

struct TimerEditView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TimerEditView(mode: .add)
            TimerEditView(mode: .edit(timer: IterationTimer(currentStamina: 10, settings: try! .init(title: "NO NAME", category: .game, maxStamina: 10, duration: 10), since: Date())))
        }
    }
}
