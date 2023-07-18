//
//  DataBase.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 17.07.2023.
//

import Foundation

class DataBase {
    
    //MARK: - Статус авторизации (логин/разлогин)
    
    class var isAuth: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "IsAuthKey")
            
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "IsAuthKey")
            UserDefaults.standard.synchronize()
        }
    }
}
 
