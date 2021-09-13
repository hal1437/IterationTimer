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
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            TimerListsView()
        }
        .onChange(of: scenePhase) { phase in
            if phase == .active {
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
    }
}
