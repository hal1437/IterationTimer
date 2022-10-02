//
//  DurationPicker.swift
//  IterationTimerUI
//
//  Created by hal1437 on 2022/06/14.
//

import SwiftUI

public struct DurationPicker: View {
    @Binding public var duration: TimeInterval
    
    let timeSequence: [TimeInterval]
    
    public init(maxMinute: Int, duration: Binding<TimeInterval>) {
        self._duration = duration
        self.timeSequence = (0..<maxMinute*2).map { TimeInterval(($0 + 1) * 30) }
    }
    
    public var body: some View {
        Picker("", selection: $duration) {
            ForEach(timeSequence, id:\.self) { i in
                Text(convertLocalize(second: i)).tag(TimeInterval(i))
            }
        }
            .pickerStyle(MenuPickerStyle())
            .font(.body)
            .padding(.horizontal, 4)
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(4)
    }
    
    func convertLocalize(second: TimeInterval) -> String {
        let f = DateComponentsFormatter()
        f.unitsStyle = .short
        f.allowedUnits = [.minute, .second]
        
        return f.string(from: TimeInterval(second))!
    }
}

struct DurationPicker_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            DurationPicker(maxMinute: 60, duration: .constant(0))
        }
    }
}
