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
    
    struct NotificationSetting {
        var type = NotificationSelection.never
        var on = "0"
        var completion = "0"
    }
    
    enum NotificationSelection: CaseIterable {
        case never, on, completion
    }
    
    @Published var timer = IterationTimer.default
    @Published var isEnableNotification = false
    
    private let storeReview: StoreReviewable

    private var cancellables: Set<AnyCancellable> = []
    private var repository: IterationTimerRepositoryProtocol
    private var oldTimer: IterationTimer?

    init(repository: IterationTimerRepositoryProtocol, timer: IterationTimer, storeReview: StoreReviewable) {
        self.repository = repository
        self.timer = timer
        self.storeReview = storeReview

        UNUserNotificationCenter.current().getNotificationSettings {
            self.isEnableNotification = $0.authorizationStatus != .denied
        }
        
        $timer
            .map(\.settings.notification)
            .filter { $0 != .never }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [unowned self] _ in
                let center = UNUserNotificationCenter.current()
                center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                    if !granted {
                        DispatchQueue.main.async {
                            self.timer.settings.notification = .never
                        }
                    }
                }
            })
            .store(in: &cancellables)

        self.oldTimer = timer
    }

    func done() {
        repository.updateTimer(id: timer.id, timer: timer)
        oldTimer?.unregisterNotification()
        
        if timer.settings.notification != .never {
            timer.registerNotification()
        } else {
            timer.unregisterNotification()
        }
        storeReview.requestReviewIfNeeded()
    }

    func delete() {
        repository.deleteTimer(id: timer.id)
    }
    
//    func divideButtonTapped() {
//        guard let currentValue = Int(input.currentValue),
//              let divideValue = Int(input.divideValue) else { return }
//
//        let resultValue = currentValue - divideValue
//
//        if resultValue < 0 { return }
//
//        input.currentValue = String(resultValue)
//    }
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
