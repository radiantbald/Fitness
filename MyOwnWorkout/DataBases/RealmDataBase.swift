//
//  StorageManager.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 20.10.2023.
//

import Foundation
import RealmSwift

class RealmDataBase {
    static let shared: RealmDataBase = .init()
    private init() {}
    
    static let listOfData = List<Data>()
    
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
    
     func set<T: Object>(_ values: [T]) -> [T] {
        let realm = try! Realm()
         
        try! realm.write {
            realm.add(values, update: .modified)
            print(realm.configuration.fileURL ?? "")
        }
         let array = realm.objects(T.self)
         return Array(array)
    }
    
    func replace<T: ExerciseImageDataModel>(_ one: T, _ two: T) -> [T] {
        let realm = try! Realm()
        try! realm.write {
            (one.image, two.image) = (two.image, one.image)
            print(realm.configuration.fileURL ?? "")
        }
         let array = realm.objects(T.self)
         return Array(array)
    }
    
    func delete(_ value: Object) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(value)
        }
    }
    
    func delete(_ values: [Object]) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(values)
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
