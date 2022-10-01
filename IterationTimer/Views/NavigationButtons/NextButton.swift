//
//  NextButton.swift
//  IterationTimer
//
//  Created by hal1437 on 2022/09/18.
//

import SwiftUI

struct NextButton<Destination: View>: View {
    var destination: () -> Destination
    
    init(destination: @autoclosure @escaping () -> Destination) {
        self.destination = destination
    }
    
    var body: some View {
        NavigationLink("CommonNext") {
            destination()
        }
    }
}

struct NextButton_Previews: PreviewProvider {
    static var previews: some View {
        NextButton(destination: Text("aaa"))
    }
}
