//
//  InputtableOnlyNumber.swift
//  IterationTimerUI
//
//  Created by hal1437 on 2022/09/03.
//

struct InputtableOnlyNumber: TextFieldInputtable {
    func isInputtable(newString: String) -> Bool {
        return Int(newString) != nil || newString == ""
    }
}
