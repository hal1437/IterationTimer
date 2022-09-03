//
//  InputtableOnlyStamina.swift
//  IterationTimerUI
//
//  Created by hal1437 on 2022/09/04.
//

struct InputtableOnlyStamina: TextFieldInputtable {
    var max: Int
    
    func isInputtable(newString: String) -> Bool {
        if newString == "" { return true }
        guard let num = Int(newString) else { return false }
        return 0 <= num && num <= max
    }
}
