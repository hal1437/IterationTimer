//
//  Main.swift
//  IterationTimer
//
//  Created by hal1437 on 2021/04/07.
//

import SwiftUI
import WidgetKit

@main
struct Main: App {
    var body: some Scene {
        WindowGroup {
            TimerListsView()
                .onAppear {
                    WidgetCenter.shared.reloadAllTimelines()
                }
        }
    }
}
