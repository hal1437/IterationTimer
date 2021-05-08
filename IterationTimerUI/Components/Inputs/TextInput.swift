//
//  TextInput.swift
//  IterationTimerUI
//
//  Created by hal1437 on 2021/05/04.
//

import SwiftUI

public struct TextInput: View {
    public var placeholder: String
    @Binding public var text: String
    
    public init(placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }

    public var body: some View {
        TextField(placeholder, text: $text)
                      .textFieldStyle(RoundedBorderTextFieldStyle())
                      .frame(width: 100)
    }
}

struct TextInput_Previews: PreviewProvider {
    static var previews: some View {
        TextInput(placeholder: "placeHolder", text: Binding<String>(get: { "" }, set: { _ in }))
            .previewLayout(.sizeThatFits)
    }
}
