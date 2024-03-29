//
//  StaminaInput.swift
//  IterationTimerUI
//
//  Created by hal1437 on 2021/05/04.
//

import SwiftUI

public struct StaminaInput: View {
    @Binding var number: Int
    var max: Int

    public init(max: Int, number: Binding<Int>) {
        self._number = number
        self.max = max
        if number.wrappedValue > max {
            number.wrappedValue = max
        }
    }
    
    public var body: some View {
        let text = Binding(get: {
            String(number)
        }, set: { str in
            if let num = Int(str) {
                number = num
            }
        })
        
        UIKitTextField("0", text: text, inputtable: InputtableOnlyStamina(max: max)) { textfield in
            textfield.keyboardType = .numberPad
            textfield.textAlignment = .right
            return textfield
        }
            .padding(4)
            .foregroundColor(Color(UIColor.link))
    }
}

struct NumberInput_Previews: PreviewProvider {
    static var previews: some View {
        StaminaInput(max: 100, number: .constant(100))
            .frame(width: 100, height: 40)
            .previewLayout(.sizeThatFits)
    }
}
