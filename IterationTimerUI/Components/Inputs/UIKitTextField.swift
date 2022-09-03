//
//  UIKitTextField.swift
//  IterationTimerUI
//
//  Created by hal1437 on 2022/09/03.
//

import SwiftUI
import UIKit

struct UIKitTextField: UIViewRepresentable {
    @Binding var text: String
    let placeholder: String
    let inputtable: TextFieldInputtable?
    var textField: UITextField?
    let constructor: ((UITextField) -> UITextField)?
    
    init(_ placeholder: String, text: Binding<String>, inputtable: TextFieldInputtable? = nil, constructor: ((UITextField) -> UITextField)? = nil) {
        self.placeholder = placeholder
        self._text = text
        self.inputtable = inputtable
        self.constructor = constructor
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.placeholder = self.placeholder
         
        if let constructor = constructor {
            return constructor(textField)
        } else {
            return textField
        }
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
}

extension UIKitTextField {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // UITextFieldDelegateを実装
    final class Coordinator: NSObject, UITextFieldDelegate {
        var parent: UIKitTextField
        
        init(_ parent: UIKitTextField) {
            self.parent = parent
            super.init()
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let inputtable = parent.inputtable,
               let text = textField.text,
               let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange, with: string)
                return inputtable.isInputtable(newString: updatedText)
            } else {
                return true
            }
        }
    }
}

struct UIKitTextField_Previews: PreviewProvider {
    static var previews: some View {
        UIKitTextField("", text: .constant("1"))
    }
}
