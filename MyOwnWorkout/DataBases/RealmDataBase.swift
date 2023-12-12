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
    
    func getExercisesData() -> [ExerciseModel] {
        let realm = try! Realm()
        let set = realm.objects(ExerciseModel.self)
        return Array(set)
    }
    
    func setExercisesData(_ title: String, _ about: String) {
        let realm = try! Realm()
        let exercises = ExerciseModel(title: title, about: about)
        try! realm.write{
            realm.add(exercises)
            print(realm.configuration.fileURL ?? "")
        }
    }
}
