//
//  TimerEditViewModel.swift
//  IterationTimer
//
//  Created by hal1437 on 2021/04/26.
//

import Combine
import Foundation
import IterationTimerModel
import NotificationCenter

class TimerEditViewModel: ObservableObject {
    
    struct Inputs {
        var category = TimerCategory.game
        var name = ""
        var currentValue = "10"
        var maxValue = "10"
        var duration = "10"
        var willPushNotify = false
    }
    
    @Published var input: Inputs = Inputs()
    var isEnabled = false
    var timer = IterationTimer(currentStamina: 10,
                               settings: try! .init(title: "NO NAME",
                                                    category: .game,
                                                    maxStamina: 10,
                                                    duration: 10,
                                                    willPushNotify: false),
                               since: Date())
    
    private var mode: TimerEditView.Mode

    private var cancellables: Set<AnyCancellable> = []
    private var repository: IterationTimerRepositoryProtocol
    private var oldTimer: IterationTimer?

    init(repository: IterationTimerRepositoryProtocol, mode: TimerEditView.Mode) {
        self.repository = repository
        self.mode = mode

        $input
            .map(TimerEditViewModel.constructTimer)
            .filter { $0 != nil }.map { $0! }
            .assign(to: \.timer, on: self)
            .store(in: &cancellables)

        $input
            .map(TimerEditViewModel.constructTimer)
            .map { $0 != nil }
            .assign(to: \.isEnabled, on: self)
            .store(in: &cancellables)

        $input
            .map(\.willPushNotify)
            .filter { $0 }
            .sink(receiveValue: { [unowned self] _ in
                let center = UNUserNotificationCenter.current()
                center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                    if !granted {
                        self.input.willPushNotify = false
                    }
                }
            })
            .store(in: &cancellables)

        if case .edit(let timer) = mode {
            self.oldTimer = timer
            self.timer = timer
            self.input = TimerEditViewModel.constructInput(timer: timer)
        }
    }

    func done() {
        let timer = TimerEditViewModel.constructTimer(input: input)!
        switch mode {
        case .add:
            let count = repository.getTimers.count
            repository.insertTimer(index: count, timer: timer)
        case .edit(let unit):
            repository.updateTimer(id: unit.id, timer: timer)
            oldTimer?.unregisterNotification()
        }
        
        if timer.settings.willPushNotify {
            timer.registerNotification()
        } else {
            timer.unregisterNotification()
        }
    }

    func delete() {
        if case .edit(let unit) = mode {
            repository.deleteTimer(id: unit.id)
        }
    }

    static private func constructTimer(input: Inputs) -> IterationTimer? {
        guard let currentStamina = Int(input.currentValue),
              let maxStamina = Int(input.maxValue),
              let duration = TimeInterval(input.duration),
              let setting = try? IterationTimerSettings(title: input.name,
                                                        category: input.category,
                                                        maxStamina: maxStamina,
                                                        duration: duration,
                                                        willPushNotify: input.willPushNotify) else { return nil }
        
        return IterationTimer(currentStamina: currentStamina,
                              settings: setting,
                              since: Date())
    }

    static private func constructInput(timer: IterationTimer) -> Inputs {
        return Inputs(category: timer.settings.category,
                      name: timer.settings.title,
                      currentValue: "\(timer.currentStamina(date: Date()))",
                      maxValue: "\(timer.settings.maxStamina)",
                      duration: "\(Int(timer.settings.duration))",
                      willPushNotify: timer.settings.willPushNotify)
    }
}
