//
//  TimerListsView.swift
//  IterationTimer
//
//  Created by hal1437 on 2021/04/07.
//

import SwiftUI
import IterationTimerUI
import IterationTimerModel
import WidgetKit

struct TimerListsView: View {
    
    @ObservedObject var viewModel = TimerListsViewModel(repository: IterationTimerRepository(dataStore: DataStoreSynchronizer(local: UserDefaults.appGroups, remote: NSUbiquitousKeyValueStore.default)))
    
    var body: some View {
        NavigationView {
            ScrollViewReader { scrollProxy in
                ScrollView {
                    if viewModel.timers.isEmpty {
                        Text("TimerNotFound")
                            .minimumScaleFactor(0.5)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    } else {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))]) {
                            ForEach(viewModel.timers) { timer in
                                if let index = viewModel.timers.firstIndex(where: { $0.id == timer.id } ) {
                                    TimerCard(drawable: IterationTimerDrawable(timer: timer, date: Date())).padding()
                                        .onTapGesture {
                                            viewModel.transitonEditView(timer: timer)
                                        }
                                        .sheet(isPresented: $viewModel.isTransitionEditTimer[index], onDismiss: viewModel.refreshTimers) {
                                            TimerEditView(timer: timer)
                                        }
                                        .id(timer.id)
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
                .onOpenURL(perform: { url in
                    withAnimation {
                        scrollProxy.scrollTo(url.uuid, anchor: .bottom)
                    }
                    viewModel.handle(url: url)
                })
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $viewModel.isTransitionAddTimer, onDismiss: viewModel.refreshTimers) {
            NavigationView {
                TimerTitleInputView()
            }
        }
        .onAppear {
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
}

extension URL {
    var uuid: UUID {
        let components = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        return UUID(uuidString: components.queryItems!.first(where: { $0.name == "id" })!.value!)!
    }
}
