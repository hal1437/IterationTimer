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
    
    @ObservedObject var viewModel = TimerListsViewModel(repository: IterationTimerRepository(dataStore: NSUbiquitousKeyValueStore.default))
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))]) {
                    ForEach(viewModel.timers) { timer in
                        if let index = viewModel.timers.firstIndex(where: { $0.id == timer.id } ) {
                            TimerCard(drawable: IterationTimerDrawable(timer: timer, date: Date())).padding()
                                .onTapGesture {
                                    viewModel.transitonEditView(timer: timer)
                                }
                                .sheet(isPresented: $viewModel.isTransitionEditTimer[index], onDismiss: viewModel.refreshTimers) {
                                    TimerEditView(mode: .edit(timer: timer))
                                }
                        }
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
            TimerEditView(mode: .add)
        }
    }
}
