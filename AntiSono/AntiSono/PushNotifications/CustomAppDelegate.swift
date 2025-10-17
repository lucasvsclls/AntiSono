//
//  CustomAppDelegate.swift
//  AntiSono
//
//  Created by Lucas Vasconcellos Côrtes on 10/14/25.
//

import UserNotifications
import SwiftUI
import CloudKit


let subscriptionID = "OutraCoisa"

class CustomAppDelegate: NSObject, UIApplicationDelegate {

    var app: AntiSonoApp?

    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {

        application.registerForRemoteNotifications()
        UNUserNotificationCenter.current().delegate = self
        return true
    }

}

extension CustomAppDelegate: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter,
         didReceive response: UNNotificationResponse) async {
        print("Notificação recebida com o título: \(response.notification.request.content.title)")
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
        willPresent notification: UNNotification)
        async -> UNNotificationPresentationOptions {

        return [.badge, .banner, .list, .sound]
    }


}
