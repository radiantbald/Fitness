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
    @Persisted var exercises: List<Data>
    @Persisted var area: String
    @Persisted var about: String
    
    convenience init(title: String,
                     author: String = "",
                     exercises: List<Data>,
                     area: String = "",
                     about: String = "") {
        self.init()
        self.title = title
        self.author = author
        self.exercises = exercises
        self.area = area
        self.about = about
    }
}
