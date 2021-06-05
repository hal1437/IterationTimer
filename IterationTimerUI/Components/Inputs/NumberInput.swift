//
//  NumberInput.swift
//  IterationTimerUI
//
//  Created by hal1437 on 2021/05/04.
//

import SwiftUI

public struct NumberInput: View {
    @Binding public var text: String

    public init(text: Binding<String>) {
        self._text = text
    }
    
    public var body: some View {
        TextField("0", text: $text)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(width: 100)
            .keyboardType(.numberPad)
    }
}

struct NumberInput_Previews: PreviewProvider {
    static var previews: some View {
        NumberInput(text: Binding<String>(get: { "" }, set: { _ in }))
            .previewLayout(.sizeThatFits)
    }
}
