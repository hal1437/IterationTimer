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
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var viewModel = TimerEditViewModel(repository: IterationTimerRepository(userDefaults: .standard))

    var body: some View {
        NavigationView {
            VStack {
                let drawable = TimerCardDrawable(timer: viewModel.timer, currentTime: Date())
                TimerCard(drawable: drawable)
                    .padding()

                Divider()
                
                ScrollView {
                    VStack {
                        HorizontalInput(title: "名前", contents: TextInput(placeholder: "名前", text: $viewModel.name))
                        Divider()
                        HorizontalInput(title: "現在値", contents: NumberInput(text: $viewModel.currentValue))
                        Divider()
                        HorizontalInput(title: "最大値", contents: NumberInput(text: $viewModel.maxValue))
                        Divider()
                        HorizontalInput(title: "1単位が回復するまでの秒数", contents: NumberInput(text: $viewModel.duration))
                        Divider()
                    }
                }
            }
            .navigationBarTitle("タイマーの追加", displayMode: .inline)
            .navigationBarItems(leading: Button("キャンセル") { self.presentationMode.wrappedValue.dismiss() },
                                trailing: Button("追加") {
                                    viewModel.addTimer()
                                    self.presentationMode.wrappedValue.dismiss()
                                })
        }
    }
}

private struct TimerCardDrawable: TimerDrawable {
    var category: CardCategory
    var title: String
    var startTime: Date
    var currentTime: Date
    var endTime: Date
    var duration: TimeInterval
    
    init(timer: IterationTimerUnit, currentTime: Date) {
        self.category = timer.category.cardCategory
        self.title = timer.title
        self.startTime = timer.startTime
        self.currentTime = currentTime
        self.endTime = timer.endTime
        self.duration = timer.duration
    }
}

struct TimerEditView_Previews: PreviewProvider {
    static var previews: some View {
        TimerEditView()
    }
}
