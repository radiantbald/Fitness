//
//  StorageManager.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 20.10.2023.
//

import Foundation
import RealmSwift

class RealmDataBase {
    static var shared: RealmDataBase = .init()
    private init() {}
    
    func get<T: Object>() -> [T] {
        let realm = try! Realm()
        let checkRealm = realm.objects(T.self)
        return Array(checkRealm)
    }
    
    func set(_ value: Object) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(value, update: .modified)
            print(realm.configuration.fileURL ?? "")
        }
    }
    
    func delete(_ value: Object) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(value)
        }
    }
    
    func deleteTable(_ value: Object.Type) {
        let realm = try! Realm()
        try! realm.write {
            let table = realm.objects(value)
            realm.delete(table)
        }
    }
}
