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
    @Published var currentStamina = 10
    @Published var settings = IterationTimerSettings.default
    @Published var isEnableNotification = false
    
    var previewTimer = IterationTimer.default
    
    private let storeReview: StoreReviewable
    private var cancellables: Set<AnyCancellable> = []
    private var repository: IterationTimerRepositoryProtocol
    private var oldTimer: IterationTimer

    init(repository: IterationTimerRepositoryProtocol, timer: IterationTimer, storeReview: StoreReviewable) {
        self.repository = repository
        self.storeReview = storeReview
        self.oldTimer = timer
        self.currentStamina = timer.currentStamina(date: Date())
        self.settings = timer.settings

        UNUserNotificationCenter.current().getNotificationSettings {
            self.isEnableNotification = $0.authorizationStatus != .denied
        }
        
        let previewTimer = $currentStamina.combineLatest($settings)
            .map { currentStamina, settings in
                IterationTimer(currentStamina: currentStamina, settings: settings, since: Date())
            }
        
        previewTimer
            .assign(to: \.previewTimer, on: self)
            .store(in: &cancellables)
    }

    func done() {
        repository.updateTimer(id: oldTimer.id, timer: previewTimer)
        oldTimer.unregisterNotification()
        
        if previewTimer.settings.notification != .never {
            previewTimer.registerNotification()
        } else {
            previewTimer.unregisterNotification()
        }
        storeReview.requestReviewIfNeeded()
    }

    func delete() {
        repository.deleteTimer(id: oldTimer.id)
    }
}
