//
//  DataBase.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 17.07.2023.
//

import Foundation

class DataBase {
    private enum Keys: String {
        case isOnAuth
    }
    
    
    //MARK: - Статус авторизации (логин/разлогин)
    
    class var isAuth: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.isOnAuth.rawValue)
            
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.isOnAuth.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
}
 
