//
//  IterationTimer+Notification.swift
//  IterationTimer
//
//  Created by hal1437 on 2021/10/03.
//

import Foundation
import IterationTimerModel
import NotificationCenter

extension IterationTimer {
    func registerNotification() {
        let notificationTrigger = self.settings.notification
        let nextNotify = self.nextNotifyDate()

        guard nextNotify > Date() else { return }
        
        let content = UNMutableNotificationContent()
        content.title = notificationTrigger.notificationtTitle(timerTitle: settings.title)
        content.sound = UNNotificationSound.default

        let timeInterval = nextNotify.timeIntervalSinceNow
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: pushIdentifier(), content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
        }
    }

    func unregisterNotification() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [pushIdentifier()])
        center.removeDeliveredNotifications(withIdentifiers: [pushIdentifier()])
    }
    
    private func pushIdentifier() -> String {
        return "IterationTimer-\(self.id)"
    }
}

extension NotificationTrigger {
    func notificationtTitle(timerTitle: String) -> String {
        switch self {
        case .never: return ""
        case .on(let stamina): return "\(timerTitle)の値が\(stamina)になりました。"
        case .completion(let before):
            if before == 0 {
                return "\(timerTitle)が回復しました"
            } else {
                return "\(timerTitle)の値が\(Int(before))秒に回復します"
            }
        }
    }
}

