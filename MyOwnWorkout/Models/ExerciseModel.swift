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
    @Persisted var photosArray: List<Data>
    
    convenience init(title: String,
                     author: String = "",
                     muscleGroup: String = "",
                     neededEquipment: String = "",
                     about: String = "",
                     photosArray: List<Data>) {
        self.init()
        self.title = title
        self.author = author
        self.muscleGroup = muscleGroup
        self.neededEquipment = neededEquipment
        self.about = about
        self.photosArray = photosArray
    }
    
    let exercisePhotosData = List<Data>()
    
    func saveExercise( _ title: String, _ about: String, _ photosArray: List<Data>) {
            let exercise = ExerciseModel(title: title, about: about, photosArray: photosArray)
            RealmDataBase.shared.set(exercise)
            let photosData = ExercisePhotoDataModel.self
            RealmDataBase.shared.deleteTable(photosData)
    }
}

class ExercisePhotoDataModel: Object {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var photo: Data
    
    convenience init(photo: Data) {
        self.init()
        self.photo = photo
    }
}

