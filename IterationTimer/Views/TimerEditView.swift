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
                        HStack {
                            Text("名前")
                            Spacer()
                            TextField("名前", text: $viewModel.name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 200)
                        }.padding()
                        
                        Divider()
                        HStack {
                            Text("最大値")
                            Spacer()
                            TextField("0", text: $viewModel.maxValue)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 50)
                        }.padding()
                        
                        Divider()

                        HStack {
                            Text("1単位が回復するまでの秒数")
                            Spacer()
                            TextField("0", text: $viewModel.duration)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 50)
                        }.padding()

                        Divider()

                        DisclosureGroup("詳細な設定") {
                            Toggle(isOn: $viewModel.isCompleteNotification) {
                                Text("回復時に通知する")
                            }
                            .padding()

                        }.padding()
                    }
                }
            }
            .navigationBarTitle("タイマーの追加", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.addTimer()
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("追加")
                    }
                }
            }
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
