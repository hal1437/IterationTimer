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
        var notification = NotificationSetting()
    }
    
    struct NotificationSetting {
        var type = NotificationSelection.never
        var on = "0"
        var completion = "0"
    }
    
    enum NotificationSelection: CaseIterable {
        case never, on, completion
    }
    
    @Published var input: Inputs = Inputs()
    var isEnabled = false
    var timer = IterationTimer(currentStamina: 10,
                               settings: try! .init(title: "",
                                                    category: .game,
                                                    maxStamina: 10,
                                                    duration: 10,
                                                    notification: .never),
                               since: Date())
    
    private var mode: TimerEditView.Mode

    private var cancellables: Set<AnyCancellable> = []
    private var repository: IterationTimerRepositoryProtocol
    private var oldTimer: IterationTimer?

    init(repository: IterationTimerRepositoryProtocol, mode: TimerEditView.Mode) {
        self.repository = repository
        self.mode = mode

        let timer = $input.map(IterationTimer.init)
        
        timer
            .filter { $0 != nil }.map { $0! }
            .assign(to: \.timer, on: self)
            .store(in: &cancellables)

        timer
            .map { $0 != nil }
            .assign(to: \.isEnabled, on: self)
            .store(in: &cancellables)

        timer
            .map(\.?.settings.notification)
            .filter { $0 != nil }.map { $0! }
            .filter { $0 != .never }
            .sink(receiveValue: { [unowned self] _ in
                let center = UNUserNotificationCenter.current()
                center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                    if !granted {
                        self.input.notification.type = .never
                    }
                }
            })
            .store(in: &cancellables)

        if case .edit(let timer) = mode {
            self.oldTimer = timer
            self.timer = timer
            self.input = .init(timer: timer)
        }
    }

    func done() {
        let timer = IterationTimer(input: input)!
        switch mode {
        case .add:
            let count = repository.getTimers.count
            repository.insertTimer(index: count, timer: timer)
        case .edit(let unit):
            repository.updateTimer(id: unit.id, timer: timer)
            oldTimer?.unregisterNotification()
        }
        
        if timer.settings.notification != .never {
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
}

private extension TimerEditViewModel.Inputs {
    init(timer: IterationTimer) {
        self.category = timer.settings.category
        self.name = timer.settings.title
        self.currentValue = "\(timer.currentStamina(date: Date()))"
        self.maxValue = "\(timer.settings.maxStamina)"
        self.duration = "\(Int(timer.settings.duration))"
        self.notification = .init(trigger: timer.settings.notification)
    }
}


private extension IterationTimer {
    init?(input: TimerEditViewModel.Inputs) {
        guard let currentStamina = Int(input.currentValue),
              let maxStamina = Int(input.maxValue),
              let duration = TimeInterval(input.duration),
              let trigger = NotificationTrigger(settings: input.notification),
              let setting = try? IterationTimerSettings(title: input.name,
                                                        category: input.category,
                                                        maxStamina: maxStamina,
                                                        duration: duration,
                                                        notification: trigger) else { return nil }
        self = .init(currentStamina: currentStamina,
                     settings: setting,
                     since: Date())
    }
}

private extension TimerEditViewModel.NotificationSetting {
    init(trigger: NotificationTrigger) {
        switch trigger {
        case .never:
            self.type = .never
        case .on(let stamina):
            self.type = .on
            self.on = "\(stamina)"
        case .completion(let before):
            self.type = .completion
            self.completion = "\(Int(before))"
        }
    }
}

private extension NotificationTrigger {
    init?(settings: TimerEditViewModel.NotificationSetting) {
        switch settings.type {
        case .never:
            self = .never
        case .on:
            guard let on = Int(settings.on) else { return nil }
            self = .on(stamina: on)
        case .completion:
            guard let completion = TimeInterval(settings.completion) else { return nil }
            self = .completion(before: completion)
        }
    }
}
