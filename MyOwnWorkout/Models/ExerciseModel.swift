//
//  ExerciseModel.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 20.10.2023.
//

import Foundation
import RealmSwift

class ExerciseModel: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String = ""
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
}
