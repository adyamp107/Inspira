//
//  InspiraApp.swift
//  Inspira
//
//  Created by Adya Muhammad Prawira on 06/04/25.
//

import SwiftUI

@main
struct InspiraApp: App {
    let notificationDelegate = NotificationDelegate()
    init() {
        UNUserNotificationCenter.current().delegate = notificationDelegate
    }
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
        .modelContainer(for: Meeting.self)
    }
}
