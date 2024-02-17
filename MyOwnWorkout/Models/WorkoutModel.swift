//
//  WorkoutModel.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 27.01.2024.
//

import Foundation
import RealmSwift

class WorkoutModel: Object {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var title: String
    @Persisted var author: String
    @Persisted var exercisesList: List<Data>
    @Persisted var area: String
    @Persisted var about: String
    
    convenience init(title: String,
                     author: String = "",
                     exercisesList: List<Data>,
                     area: String = "",
                     about: String = "") {
        self.init()
        self.title = title
        self.author = author
        self.exercisesList = exercisesList
        self.area = area
        self.about = about
    }
    
    func saveWorkout(_ title: String, _ about: String, _ exercisesList: List<Data>) {
        let workout = WorkoutModel(title: title, exercisesList: exercisesList, about: about)
        RealmDataBase.shared.set(workout)
//        let exercisesData = ExerciseModel.self
//        RealmDataBase.shared.deleteTable(exercisesData)
    }
}
