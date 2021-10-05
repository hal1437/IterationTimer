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
        let timeInterval = self.remainingFull(date: Date())
        
        if timeInterval <= 0 { return }
        
        // タイトル、本文、サウンド設定の保持
        let content = UNMutableNotificationContent()
        content.title = "\(settings.title)が回復しました。"
        
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
