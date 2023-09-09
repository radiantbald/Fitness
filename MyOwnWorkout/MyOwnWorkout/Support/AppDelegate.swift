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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        configureFirebase(for: application)
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    //MARK: - Показ пуша при скрытом приложении (при наличии метода willPresent этот метод не сработает)
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
    ) {
        
        if Auth.auth().canHandleNotification(userInfo) {
          completionHandler(.noData)
          return
        }
        print("Пришел пуш при развернутом приложении") // работает только если показ пушей для развернутого приложения выключен
    }
    
  
    
    
    //MARK: - получение токена устройства
    
    func application( _ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        
        let token = tokenParts.joined()
        print("Device token - ", token)
        
        Auth.auth().setAPNSToken(deviceToken, type: .prod)
        
        Messaging.messaging().apnsToken = deviceToken
    }
    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        print("Error \(error._code): ", error.localizedDescription)
    }
    
    //MARK: - Показ пуша при развернутом приложении
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.alert, .badge, .sound])
        guard let data = notification.request.content.userInfo as? [String : AnyObject] else { return }
        setupData(data)
    }
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        
        if let userInfo = response.notification.request.content.userInfo as? [String : AnyObject] {
            setupData(userInfo)
            print("didReceive response")
        }
        completionHandler()
    }
    private func setupData(_ userInfo: [String : AnyObject]) {
        userInfo.forEach { (key, value) in
            print(key, " - ", value)
        }
    }
}


//MARK: - Делегат FirebaseMessaging

extension AppDelegate: MessagingDelegate {
    
    //MARK: - Получение токена приложения на устройстве
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FCMToken"), object: fcmToken)
        print("FCM token - ", fcmToken!)
    }
    
    //MARK: - Первичная настройка firebase
    
    private func configureFirebase(for application: UIApplication) {
        
        FirebaseApp.configure()
        
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        Messaging.messaging().isAutoInitEnabled = true
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in})
        
        UIApplication.shared.applicationIconBadgeNumber = 21
        
        application.registerForRemoteNotifications()
    }
    
    
//    func registerPushNotifications(application: UIApplication) {
//        NotificationCenter.default.addObserver(self, selector: #selector(updatingFCMToken), name: NSNotification.Name(rawValue: "FCMToken"), object: nil)
//
//        Messaging.messaging().delegate = self
//
//        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { granted, _ in
//            if granted {
//                self.getNotificationSettings(application)
//            }
//        })
//    }
//
//    func getNotificationSettings(_ application: UIApplication) {
//        UNUserNotificationCenter.current().getNotificationSettings { settings in
//            DispatchQueue.main.async {
//                application.registerForRemoteNotifications()
//            }
//        }
//    }

}

extension AppDelegate {
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
      
        print("url ->", url)
        
        if Auth.auth().canHandle(url) {
        return true
      }
      
        return true
    }
}
