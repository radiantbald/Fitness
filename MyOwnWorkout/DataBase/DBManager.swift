//
//  DBManager.swift
//  MyOwnWorkout
//
//  Created by Алмаз Рахматуллин on 18.10.2023.
//

import Foundation
import RealmSwift

class DBManager {
    static var shared: DBManager = .init()
    private init() {}
    
    func getExercises() -> Results<Exercises> {
        let realm = try! Realm()
        return realm.objects(Exercises.self)
    }
    
    
    
    func add(_ text: String) {
        let realm = try! Realm()
        
        let value = Exercises(name: text, surname: "")
        try! realm.write {
            realm.add(value)
            print(realm.configuration.fileURL)
            print(realm.configuration.seedFilePath)
            
        }
    }
    
}
