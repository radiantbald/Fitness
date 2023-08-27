//
//  AppDelegate.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 20.05.2023.
//

import UIKit
import Firebase
import FirebaseMessaging
import UserNotificationsUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().delegate = self
        FirebaseApp.configure()
        Messaging.messaging()
        Messaging.messaging().isAutoInitEnabled = true
        
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("App-check-1")
    }
}

extension AppDelegate: MessagingDelegate {
    
    func registerPushNotifications(application: UIApplication) {
        NotificationCenter.default.addObserver(self, selector: #selector(updatingFCMToken), name: NSNotification.Name(rawValue: "FCMToken"), object: nil)
        
        Messaging.messaging().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { granted, _ in
            if granted {
                self.getNotificationSettings(application)
            }
        })
    }
    
    func getNotificationSettings(_ application: UIApplication) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FCMToken"), object: fcmToken)
    }
    
    @objc func updatingFCMToken(_ notification: Notification) {
        guard let fcmToken = notification.object as? String else { return }
        print("FCMToken:", fcmToken)
    }
}
