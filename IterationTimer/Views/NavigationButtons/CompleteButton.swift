//
//  CompleteButton.swift
//  IterationTimer
//
//  Created by hal1437 on 2022/09/18.
//

import SwiftUI

struct CompleteButton: View {
    var onTapped: () -> Void
    
    var body: some View {
        Button(LocalizedStringKey("CommonComplete"), action: onTapped)
    }
}

struct CompleteButton_Previews: PreviewProvider {
    static var previews: some View {
        CompleteButton { }
    }
}
