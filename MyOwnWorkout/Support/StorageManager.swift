//
//  StorageManager.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 17.10.2023.
//

import Foundation

protocol StorageManagerProtocol {
    func set(_ object: Any?, forKey key: StorageManager.Keys)
    func setCodableData<T: Encodable>(object: T?, forKey key: StorageManager.Keys)
    
    func getBool(forKey key: StorageManager.Keys) -> Bool?
    func getInt(forKey key: StorageManager.Keys) -> Int?
    func getString(forKey key: StorageManager.Keys) -> String?
    func getDict(forKey key: StorageManager.Keys) -> [String: Any]?
    func getDate(forKey key: StorageManager.Keys) -> Date?
    func getData(forKey key: StorageManager.Keys) -> Data?
    func getCodableData<T: Decodable>(forKey key: StorageManager.Keys) -> T?
}

final class StorageManager {
    
    public enum Keys: String {
        case exercises = "Exercises"
    }
    
    private let userDefaults = UserDefaults.standard
    
    private func store(_ object: Any?, key: String) {
        userDefaults.set(object, forKey: key)
    }
    
    private func restore(forKey key: String) -> Any? {
        userDefaults.object(forKey: key)
    }
}

extension StorageManager: StorageManagerProtocol {
    func set(_ object: Any?, forKey key: Keys) {
        store(object, key: key.rawValue)
        userDefaults.synchronize()
    }
    
    func setCodableData<T: Encodable>(object: T?, forKey key: Keys) {
        let jsonData = try? JSONEncoder().encode(object)
        store(object, key: key.rawValue)
        userDefaults.synchronize()
    }
    
    func getBool(forKey key: Keys) -> Bool? {
        restore(forKey: key.rawValue) as? Bool
    }
    
    func getInt(forKey key: Keys) -> Int? {
        restore(forKey: key.rawValue) as? Int
    }
    
    func getString(forKey key: Keys) -> String? {
        restore(forKey: key.rawValue) as? String
    }
    
    func getDict(forKey key: Keys) -> [String : Any]? {
        restore(forKey: key.rawValue) as? [String : Any]
    }
    
    func getDate(forKey key: Keys) -> Date? {
        restore(forKey: key.rawValue) as? Date
    }
    
    func getData(forKey key: Keys) -> Data? {
        restore(forKey: key.rawValue) as? Data
    }
    
    func getCodableData<T: Decodable>(forKey key: Keys) -> T? {
        guard let jsonData = restore(forKey: key.rawValue) as? Data else { return nil}
        return try? JSONDecoder().decode(T.self, from: jsonData)
    }
    
    func remove(forKey key: Keys) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
    
}
