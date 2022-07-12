//
//  NumberPicker.swift
//  IterationTimerUI
//
//  Created by hal1437 on 2022/05/24.
//

import SwiftUI

public struct NumberPicker: View {
    @Binding public var text: Int
    let max: Int

    public init(max: Int, text: Binding<Int>) {
        self.max = max
        self._text = text
    }
    
    public var body: some View {
        
        Picker("", selection: $text) {
            ForEach((0 ... max), id:\.self) { i in
                Text(String(i)).tag(i)
            }
        }
            .pickerStyle(MenuPickerStyle())
            .font(.body)
            .padding(.horizontal, 4)
            .background(.secondarySystemBackground)
            .cornerRadius(4)
    }
}

struct NumberPicker_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            NumberPicker(max: 100, text: Binding<Int>(get: { 0 }, set: { _ in }))
        }
    }
}
