//
//  DurationPicker.swift
//  IterationTimerUI
//
//  Created by hal1437 on 2022/06/14.
//

import SwiftUI

public struct DurationPicker: View {
    @Binding public var duration: TimeInterval
    
    let timeSequence = (1...119).map { TimeInterval($0 * 30) }
    
    public init(duration: Binding<TimeInterval>) {
        self._duration = duration
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
            .background(.secondarySystemBackground)
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
            DurationPicker(duration: Binding<TimeInterval>(get: { 0 }, set: { _ in }))
        }
    }
}
