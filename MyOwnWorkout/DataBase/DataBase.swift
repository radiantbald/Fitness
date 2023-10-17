//
//  DataBase.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 17.07.2023.
//

import Foundation

class DataBase {
    
    //MARK: - Список Ключей
    
    private enum AuthKeys: String {
        //MARK: Bool
        case AuthKey = "AuthKey"
    }
    
    private enum ExerciseKeys: String {
        case ExerciseName = "ExerciseName"
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
    
    class var exerciseGetSet: String? {
        get {
            return UserDefaults.standard.string(forKey: ExerciseKeys.ExerciseName.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: ExerciseKeys.ExerciseName.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
}
 
