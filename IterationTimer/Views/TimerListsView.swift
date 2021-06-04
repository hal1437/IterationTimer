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
                    ForEach(viewModel.timers) { unit in
                        
                        TimerCard(drawable: IterationTimerDrawable(timer: unit, date: Date())).padding()
                            .onTapGesture {
                                viewModel.isTransitionEditTimer = true
                            }
                            .sheet(isPresented: $viewModel.isTransitionEditTimer, onDismiss: viewModel.refreshTimers) {
                                TimerEditView(mode: .edit(timer: unit))
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
