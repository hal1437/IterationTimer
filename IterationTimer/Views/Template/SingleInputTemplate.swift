//
//  SingleInputTemplate.swift
//  IterationTimer
//
//  Created by hal1437 on 2022/09/18.
//

import SwiftUI

struct SingleInputTemplate<Input: View>: View {
    enum Field: Hashable {
        case input
    }
    
    @FocusState private var focusedField: Field?

    let title: String
    let header: String
    let footer: String
    let input: Input

    var body: some View {
        Form {
            Section(header: Text(header), footer: Text(footer)) {
                input
                    .focused($focusedField, equals: .input)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.focusedField = .input
                        }
                    }
            }
        }
        .navigationTitle(title)
        .onTapGesture {
            focusedField = nil
        }
    }
}

struct SingleInputTemplate_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SingleInputTemplate(title: "SingleInputTemplate",
                                header: String(repeating: "header", count: 10),
                                footer: String(repeating: "footer", count: 500),
                                input: TextField("title", text: .constant("")))
        }
    }
}
