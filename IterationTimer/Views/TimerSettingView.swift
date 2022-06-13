//
//  TimerSettingView.swift
//  IterationTimer
//
//  Created by hal1437 on 2022/06/10.
//

import SwiftUI
import IterationTimerCore
import IterationTimerUI
import IterationTimerModel

struct TimerSettingView: View {
    @State var num = "10"
    @State var isVisible = true
    @State var maxValue = "10"
    @State var duration = "10"
    @State var divideValue = "10"

    @Environment(\.editMode) var editMode
    private let timer: IterationTimer
    

    init(timer: IterationTimer) {
        self.timer = timer
    }

    var body: some View {
        Form {
            if editMode?.wrappedValue.isEditing == false {
                Section(header: Text("TimerEditStaminaSection")) {
                    HStack {
                        Text("TimerEditMaxValue")
                            .frame(width: 100, alignment: .leading)
                        Spacer()
                        NumberPicker(max: 100, text: $maxValue)
                    }

                    HStack {
                        Text("TimerEditDuration")
                            .frame(width: 100, alignment: .leading)
                        Spacer()
                        NumberPicker(max: 100, text: $duration)
                    }
                    HStack {
                        Text("分割値")
                            .frame(width: 100, alignment: .leading)
                        Spacer()
                        NumberPicker(max: 100, text: $divideValue)
                    }
                }
            }

            Section(header: Text("TimerEditStaminaSection")) {
                HStack {
                    Text("TimerEditMaxValue")
                        .frame(width: 100, alignment: .leading)
                    TextField("0", text: $maxValue)
                        .keyboardType(.numberPad)
                }

                HStack {
                    Text("TimerEditDuration")
                        .frame(width: 100, alignment: .leading)
                    TextField("0", text: $duration)
                        .keyboardType(.numberPad)
                }
                HStack {
                    Text("分割値")
                        .frame(width: 100, alignment: .leading)
                    TextField("0", text: $divideValue)
                        .keyboardType(.numberPad)
                }
            }

        }
        .toolbar {
            EditButton()
        }
        .navigationBarTitle("TimerEditTimerSetting")
    }
}

struct TimerSettingView_Previews: PreviewProvider {
    static var previews: some View {
        TimerSettingView(timer: IterationTimer(currentStamina: 10, settings: try! .init(title: "NO NAME", category: .game, maxStamina: 10, divideStamina: 10, duration: 10, notification: .never), since: Date()))
    }
}
