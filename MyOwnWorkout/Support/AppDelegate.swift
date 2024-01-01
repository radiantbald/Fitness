//
//  AppDelegate.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 20.05.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication,didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureFirebase(for: application)
        RealmDataBase.shared.deleteTable(ExerciseImageDataModel.self)
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        RealmDataBase.shared.deleteTable(ExerciseImageDataModel.self)
    }
}
