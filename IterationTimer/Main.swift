//
//  Main.swift
//  IterationTimer
//
//  Created by hal1437 on 2021/04/07.
//

import SwiftUI
import Firebase
import WidgetKit

@main
struct Main: App {

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            TimerListsView()
        }
    }
}
