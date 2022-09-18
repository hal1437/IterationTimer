//
//  CancelButton.swift
//  IterationTimer
//
//  Created by hal1437 on 2022/09/18.
//

import SwiftUI

struct CancelButton: View {
    var onTapped: () -> Void
    
    var body: some View {
        Button(LocalizedStringKey("CommonCancel"), action: onTapped)
    }
}

struct CancelButton_Previews: PreviewProvider {
    static var previews: some View {
        CancelButton { }
    }
}
