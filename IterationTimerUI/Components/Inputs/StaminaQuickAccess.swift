//
//  StaminaQuickAccess.swift
//  IterationTimerUI
//
//  Created by hal1437 on 2022/05/24.
//

import SwiftUI
import SwiftUIX

public struct StaminaQuickAccess: View {
    let text: String
    let count: Int
    let action: ()->Void

    public init(text: String, count: Int, action: @escaping ()->Void) {
        self.text = text
        self.count = count
        self.action = action
    }
    
    public var body: some View {
        HStack {
            Button(text, action: action)
            Spacer()
            Text(String(count))
                .foregroundColor(.link)
        }
    }
}

struct StaminaQuickAccess_Previews: PreviewProvider {
    static var previews: some View {
        StaminaQuickAccess(text: "クエスト1", count: -30) {
            print("tapped")
        }
    }
}
