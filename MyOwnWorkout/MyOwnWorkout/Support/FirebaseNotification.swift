//
//  FirebaseNotification.swift
//  MyOwnWorkout
//
//  Created by Алмаз Рахматуллин on 23.08.2023.
//

import Foundation
import Firebase
import FirebaseMessaging
import UserNotificationsUI


extension AppDelegate: UNUserNotificationCenterDelegate {
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("App-Check-1")
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        
        let token = tokenParts.joined()
        print("token: ", token)
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Error \(error._code): ", error.localizedDescription)
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
        guard let data = notification.request.content.userInfo as? [String : AnyObject] else {return}
        setupData(data)
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if let userInfo = response.notification.request.content.userInfo as? [String : AnyObject] {
            setupData(userInfo)}
        completionHandler()
    }
    
    private func setupData(_ userInfo: [String : AnyObject]) {
        userInfo.forEach { (key, value) in
            print(key, " -> ", value)
        }

        UIApplication.shared.applicationIconBadgeNumber = 0
    }
}


extension AppDelegate: MessagingDelegate {
    
    //регистрация, получение разрешения в первый раз
    func registerPushNotifications(application: UIApplication) {
        NotificationCenter.default.addObserver(self, selector: #selector(updatingFCMToken(_:)), name: NSNotification.Name(rawValue: "FCMToken"), object: nil)
        
        Messaging.messaging().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { granted, _ in
            if granted {
                self.getNotificationSettings(application)
            }
        })
    }
    
    // обновление и проверка на разрешение
    func getNotificationSettings(_ application: UIApplication) {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            DispatchQueue.main.async { application.registerForRemoteNotifications() }
        }
    }
    
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FCMToken"), object: fcmToken)
    }
    
    @objc private func updatingFCMToken(_ notification: Notification) {
        guard let fcmToken = notification.object as? String else { return }
        print("FCM token: ", fcmToken)
    }
    
}
