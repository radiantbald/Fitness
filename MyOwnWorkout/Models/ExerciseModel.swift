//
//  ExerciseModel.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 20.10.2023.
//

import Foundation
import RealmSwift

class ExerciseModel: Object {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var title: String
    @Persisted var author: String
    @Persisted var muscleGroup: String
    @Persisted var neededEquipment: String
    @Persisted var about: String
    @Persisted var photosArray: String
    
    convenience init(title: String,
                     author: String = "",
                     muscleGroup: String = "",
                     neededEquipment: String = "",
                     about: String = "",
                     photosArray: String = "" ) {
        self.init()
        self.title = title
        self.author = author
        self.muscleGroup = muscleGroup
        self.neededEquipment = neededEquipment
        self.about = about
        self.photosArray = photosArray
    }
}
