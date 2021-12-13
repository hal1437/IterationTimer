//
//  TimerListsViewModel.swift
//  IterationTimer
//
//  Created by hal1437 on 2021/04/13.
//

import Combine
import Foundation
import IterationTimerModel

class TimerListsViewModel: ObservableObject {
    
    @Published var timers: [IterationTimer]
    @Published var isTransitionAddTimer = false
    @Published var isTransitionEditTimer: [Bool] = [false]
    @Published var currentTime = Date()
    
    private var repository: IterationTimerRepositoryProtocol
    private var cancellables: Set<AnyCancellable> = []

    init(repository: IterationTimerRepositoryProtocol) {
        self.repository = repository
        timers = repository.getTimers
        
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .filter { _ in !self.isTransitionAddTimer && self.isTransitionEditTimer.allSatisfy { !$0 } }
            .sink { _ in self.currentTime = Date() }
            .store(in: &cancellables)

        $timers
            .map(\.count)
            .removeDuplicates()
            .map { [Bool](repeating: false, count: $0) }
            .assign(to: \.isTransitionEditTimer, on: self)
            .store(in: &cancellables)
    }
    
    func transitonAddView() {
        isTransitionAddTimer = true
    }

    func transitonEditView(timer: IterationTimer) {
        isTransitionEditTimer = timers.map {
            $0.id == timer.id
        }
    }
    
    func refreshTimers() {
        timers = repository.getTimers
    }
    
    func handle(url: URL) {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        guard let uuidString = components.queryItems?.first(where: { $0.name == "id" })?.value else { return }
        
        isTransitionEditTimer = timers.map {
            $0.id == UUID(uuidString: uuidString)
        }
    }
}
