//
//  EmptyNavigator.swift
//  IterationTimer
//
//  Created by hal1437 on 2021/05/02.
//

import SwiftUI

struct EmptyNavigator<Contents, Destination>: View where Contents: View, Destination : View {
    @State var isActive = false
    var contents: Contents
    var destination: Destination
    
    var body: some View {
        contents
            .onTapGesture {
                self.isActive = true
            }
            .background(
                 NavigationLink (
                      destination: destination, isActive: $isActive,
                      label: {
                            EmptyView()
                      }
                 )
            )

    }
}
