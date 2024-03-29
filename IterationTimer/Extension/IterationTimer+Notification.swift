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

extension IterationTimerNotificationTrigger {
    func notificationtTitle(timerTitle: String) -> String {
        switch self {
        case .never: return ""
        case .on(let stamina):
            return String(format: NSLocalizedString("NotificationOn", comment: ""), timerTitle, stamina)
        case .completion(let before):
            if before == 0 {
                return String(format: NSLocalizedString("NotificationCompleted", comment: ""), timerTitle)
            } else {
                return String(format: NSLocalizedString("NotificationCompleteBefore", comment: ""), timerTitle, Int(before))
            }
        }
    }
}

