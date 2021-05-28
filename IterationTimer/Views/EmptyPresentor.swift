//
//  EmptyPresentor.swift
//  IterationTimer
//
//  Created by hal1437 on 2021/05/09.
//

import SwiftUI

struct EmptyPresentor<Contents, Destination>: View where Contents: View, Destination : View {
    @State var isActive = false
    var contents: Contents
    var destination: Destination
    
    var body: some View {
        contents
            .onTapGesture {
                self.isActive = true
            }
            .sheet(isPresented: $isActive) {
                destination
            }
    }
}
