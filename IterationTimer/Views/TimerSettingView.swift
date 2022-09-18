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
    @Environment(\.editMode) var editMode
    @Binding var settings: IterationTimerSettings
    
    var body: some View {
        Form {
            if editMode?.wrappedValue.isEditing == false {
                Section(header: Text("TimerEditStaminaSection")) {
                    HStack {
                        Text("TimerEditMaxValue")
                        Spacer()
                        StaminaInput(max: 9999, number: $settings.maxStamina)
                    }

                    HStack {
                        Text("TimerEditDuration")
                        Spacer()
                        DurationPicker(maxMinute: 60, duration: $settings.duration)
                    }
                    HStack {
                        Text("分割値")
                        Spacer()
                        StaminaInput(max: settings.maxStamina, number: $settings.divideStamina)
                    }
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
        TimerSettingView(settings: .init(get: { .default }, set: { _ in }))
    }
}
