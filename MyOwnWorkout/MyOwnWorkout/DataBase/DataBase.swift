//
//  DataBase.swift
//  MyOwnWorkout
//
//  Created by Алмаз Рахматуллин on 12.07.2023.
//

import Foundation
class DataBase {
    class var isAuth: Bool {
        get { return  UserDefaults.standard.bool(forKey: "IsAuthForKey") }
        set {
            UserDefaults.standard.set(newValue, forKey: "IsAuthForKey")
            UserDefaults.standard.synchronize()
        }
    }
    static var dddddd: Bool = UserDefaults.standard.bool(forKey: "IsAuthForKey")
}
