//
//  NotificationManager.swift
//  Inspira
//
//  Created by Adya Muhammad Prawira on 09/04/25.
//

import Foundation
import UserNotifications

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .list, .sound])
    }
}

func requestNotificationPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
        if let error = error {
            print("Permission error: \(error)")
        } else {
            print("🔔 Notification permission granted? \(granted)")
        }
    }
}

func scheduleNotification(for meeting: Meeting) {
    let content = UNMutableNotificationContent()
    content.title = "Meeting Today 📅"
    content.body = "Don't forget: \(meeting.topic.isEmpty ? "Untitled" : meeting.topic) is scheduled for today."
    content.sound = .default
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
    let request = UNNotificationRequest(identifier: meeting.id.uuidString, content: content, trigger: trigger)
    UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
            print("❌ Error scheduling notification: \(error)")
        } else {
            print("✅ Notification scheduled today for \(meeting.topic)")
        }
    }
}
