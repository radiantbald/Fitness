//
//  DataBase.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 17.07.2023.
//

import Foundation

class UserDefaultsDataBase {
    
    //MARK: - Список Ключей
    
    private enum AuthKeys: String {
        case AuthKey = "AuthKey"
    }
    
    private enum ExerciseKeys: String {
        case ExercisePhotoKey = "ExercisePhotoKey"
    }
    
    //MARK: - Статус авторизации (логин/разлогин)
    
    class var isAuth: Bool {
        get {
            return UserDefaults.standard.bool(forKey: AuthKeys.AuthKey.rawValue)
            
        }
        set {
            UserDefaults.standard.set(newValue, forKey: AuthKeys.AuthKey.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
}
 
