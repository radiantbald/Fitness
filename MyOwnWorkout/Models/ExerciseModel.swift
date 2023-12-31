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
    @Persisted var imagesDataList: List<Data>
    
    convenience init(title: String,
                     author: String = "",
                     muscleGroup: String = "",
                     neededEquipment: String = "",
                     about: String = "",
                     imagesDataList: List<Data>) {
        self.init()
        self.title = title
        self.author = author
        self.muscleGroup = muscleGroup
        self.neededEquipment = neededEquipment
        self.about = about
        self.imagesDataList = imagesDataList
    }
    
    let exerciseImagesData = List<Data>()
    
    func saveExercise(_ title: String, _ about: String, _ imagesDataList: List<Data>) {
            let exercise = ExerciseModel(title: title, about: about, imagesDataList: imagesDataList)
            RealmDataBase.shared.set(exercise)
            let imageData = ExerciseImageDataModel.self
            RealmDataBase.shared.deleteTable(imageData)
    }
}

//MARK: - Временная БД для хранения данных изображений упражнения

class ExerciseImageDataModel: Object {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var image: Data
    
    convenience init(image: Data) {
        self.init()
        self.image = image
    }
}

