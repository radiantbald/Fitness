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
    
    func add(_ value: Object) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(value, update: .modified)
        }
    }
    
    func delete(exercise: Object) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(exercise)
        }
    }
}
