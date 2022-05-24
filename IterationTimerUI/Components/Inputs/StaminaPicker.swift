//
//  StaminaPicker.swift
//  IterationTimerUI
//
//  Created by hal1437 on 2022/05/24.
//

import SwiftUI
import SwiftUIX

public struct StaminaPicker: View {
    @Binding public var text: String
    let max: Int

    public init(max: Int, text: Binding<String>) {
        self.max = max
        self._text = text
    }
    
    public var body: some View {
        
        CocoaTextField("0", text: $text)
            .inputView(picker)
            .inputAccessoryView(toolber)
            .font(.body)
            .fixedSize()
            .padding(.horizontal, 4)
            .background(.secondarySystemBackground)
            .cornerRadius(4)
    }
    
    private var picker: some View {
        Picker("", selection: $text) {
            ForEach((0 ... max).map { String($0) }, id:\.self) { i in
                Text(i).tag(i)
            }
        }
        .pickerStyle(WheelPickerStyle())
    }
    
    private var toolber: some View {
        HStack {
            Spacer()
            Button("CommonClose") {
                print("aaa")
            }
        }
    }

}

struct StaminaPicker_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            StaminaPicker(max: 100, text: Binding<String>(get: { "" }, set: { _ in }))
        }
    }
}
