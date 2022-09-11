//
//  TimerSettingViewModel.swift
//  IterationTimer
//
//  Created by hal1437 on 2022/09/12.
//

import Foundation
import IterationTimerCore
import Combine

class TimerSettingViewModel: ObservableObject {
    @Published var title = IterationTimerSettings.default.title
    @Published var category = IterationTimerSettings.default.category
    @Published var maxStamina = IterationTimerSettings.default.maxStamina
    @Published var divideStamina = IterationTimerSettings.default.divideStamina
    @Published var duration = IterationTimerSettings.default.duration
    @Published var notification = IterationTimerSettings.default.notification
    var settings: IterationTimerSettings?
    private var cancellables: Set<AnyCancellable> = []

    init() {
        let currentSettings = $title
            .combineLatest($category, $maxStamina, $divideStamina)
            .combineLatest($duration, $notification)
            .map { (arg0, duration, notification) -> IterationTimerSettings? in
                let (title, category, maxStamina, divideStamina) = arg0
                return try? IterationTimerSettings.init(title: title,
                                                        category: category,
                                                        maxStamina: maxStamina,
                                                        divideStamina: divideStamina,
                                                        duration: duration,
                                                        notification: notification) }

        currentSettings
            .assign(to: \.settings, on: self)
            .store(in: &cancellables)

    }
}
