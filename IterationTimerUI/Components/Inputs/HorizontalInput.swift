//
//  HorizontalInput.swift
//  IterationTimerUI
//
//  Created by hal1437 on 2021/05/04.
//

import SwiftUI

public enum HorizontalInputType {
    case text
    case number

    @ViewBuilder
    func view(text: Binding<String>) -> some View {
        switch self {
        case .text:
            TextField("名前", text: text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 200)
        case .number:
            TextField("0", text: text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 50)
        }
    }
}


public struct HorizontalInput<Contents>: View where Contents: View {
    var title: String
    var contents: Contents
        
    public init(title: String, contents: Contents) {
        self.title = title
        self.contents = contents
    }

    public var body: some View {
        HStack {
            Text(title)
            Spacer()
            contents
            
        }.padding()
    }
}

struct HorizontalInput_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HorizontalInput(title: "名前1",
                            contents: TextField("0", text: Binding<String>(get: { "" }, set: { _ in }))
                                          .textFieldStyle(RoundedBorderTextFieldStyle())
                                          .frame(width: 50))
                .previewLayout(.sizeThatFits)
        }

    }
}

