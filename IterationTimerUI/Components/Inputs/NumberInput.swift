//
//  NumberInput.swift
//  IterationTimerUI
//
//  Created by hal1437 on 2021/05/04.
//

import SwiftUI

public struct NumberInput: View {
    @Binding public var number: Int

    public init(number: Binding<Int>) {
        self._number = number
    }
    
    public var body: some View {
        let text = Binding(get: {
            String(number)
        }, set: { str in
            number = Int(str)!
        })
        
        UIKitTextField("0", text: text, inputtable: InputtableOnlyNumber()) { textfield in
            textfield.keyboardType = .numberPad
            return textfield
        }
            .padding(4)
            .foregroundColor(.link)
            .frame(width: 100, height: 30)
    }
}

struct NumberInput_Previews: PreviewProvider {
    static var previews: some View {
        NumberInput(number: .constant(100))
            .previewLayout(.sizeThatFits)
    }
}
