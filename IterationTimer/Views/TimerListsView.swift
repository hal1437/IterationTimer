//
//  TimerListsView.swift
//  IterationTimer
//
//  Created by hal1437 on 2021/04/07.
//

import SwiftUI
import IterationTimerUI
import IterationTimerModel

struct TimerListsView: View {
    
    @ObservedObject var viewModel = TimerListsViewModel(repository: IterationTimerRepository(userDefaults: .standard))
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))]) {
                    ForEach(viewModel.timers, id: \.uuid) {
                        
                        let drawable = TimerCardDrawable(timer: $0, currentTime: viewModel.currentTime)
                        
                        EmptyNavigator(contents: TimerCard(drawable: drawable).padding(),
                                       destination: Text("a").navigationTitle("TT"))
                    }
                }
            }
            .navigationTitle("Timers")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: viewModel.transitonAddView) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $viewModel.isTransitionAddTimer, onDismiss: viewModel.refreshTimers) {
            TimerEditView()
        }
    }
}

private struct TimerCardDrawable: TimerDrawable {
    var category: CardCategory
    var title: String
    var startTime: Date
    var currentTime: Date
    var endTime: Date
    var duration: TimeInterval
    
    init(timer: IterationTimerUnit, currentTime: Date) {
        self.category = timer.category.cardCategory
        self.title = timer.title
        self.startTime = timer.startTime
        self.currentTime = currentTime
        self.endTime = timer.endTime
        self.duration = timer.duration
    }
}