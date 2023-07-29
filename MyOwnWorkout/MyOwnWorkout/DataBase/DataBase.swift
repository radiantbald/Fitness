//
//  DataBase.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 17.07.2023.
//

import Foundation

class DataBase {
    
    //MARK: - Список Ключей
    
    private enum Keys: String {
        case isAuthKey = "IsAuthKey"
        case isNewAvatarImageKey = "IsNewAvatarImageKey"
    }
    
    //MARK: - Статус авторизации (логин/разлогин)
    
    class var isAuth: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.isAuthKey.rawValue)
            
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.isAuthKey.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
}
 
