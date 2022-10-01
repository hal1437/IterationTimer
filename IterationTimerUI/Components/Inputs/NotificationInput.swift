//
//  NotificationInput.swift
//  IterationTimerUI
//
//  Created by hal1437 on 2022/09/04.
//

import SwiftUI
import IterationTimerCore

public struct NotificationInput: View {
    public enum NotificationTrigger {
        case never
        case on(stamina: Int)
        case completion(before: TimeInterval)
    }

    enum NotificationSelection: CaseIterable {
        case never, on, completion
        var title: String {
            switch self {
            case .never: return NSLocalizedString("TimerEditNotificationSelectionNever", comment: "")
            case .on: return NSLocalizedString("TimerEditNotificationSelectionOn", comment: "")
            case .completion: return NSLocalizedString("TimerEditNotificationSelectionCompletion", comment: "")
            }
        }
    }
    
    @Binding var notification: NotificationTrigger
    @State private var selection = NotificationSelection.never
    @State private var on = 0
    @State private var completion = TimeInterval(0)
    private var max: Int
    
    public init(max: Int, notification: Binding<NotificationTrigger>) {
        self._notification = notification
        self.max = max
    }
    
    public var body: some View {
        Picker("TimerEditNotification", selection: $selection) {
            ForEach(NotificationSelection.allCases, id: \.self) {
                Text($0.title)
            }
        }

        switch selection {
        case .never: EmptyView()
        case .on:
            HStack {
                Text("TimerEditNotificationOn")
                    .frame(width: 100, alignment: .leading)
                Spacer()
                StaminaInput(max: max, number: $on)
            }
        case .completion:
            HStack {
                Text("TimerEditNotificationCompleteBefore")
                    .frame(width: 100, alignment: .leading)
                Spacer()
                DurationPicker(maxMinute: 60, duration: $completion)
            }
        }

    }
}

struct NotificationInput_Previews: PreviewProvider {
    static var previews: some View {
        NotificationInput(max: 100, notification: .constant(.never))
    }
}
