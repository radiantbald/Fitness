//
//  ExercisePhotosCollectionModel.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 22.12.2023.
//

import UIKit

class ExercisePhotosCollectionModel {
    
    var photo: UIImage
    
    init(photo: UIImage) {
        self.photo = photo
    }


//    class func fetchPhoto() -> [ExercisePhotosCollectionModel] {
//
//        let first = ExercisePhotosCollectionModel(photo: UIImage.gifImageWithName("Gachigif")!)
//        let second = ExercisePhotosCollectionModel(photo: UIImage(named: "gachi2")!)
//        let third = ExercisePhotosCollectionModel(photo: UIImage(named: "gachi3")!)
//        let forth = ExercisePhotosCollectionModel(photo: UIImage(named: "gachi4")!)
//
//        return [first, second]
//    }
}

struct Constants {
    static let leftDistanceToView: CGFloat = 30
    static let rightDistanceToView: CGFloat = 30
    static let minimumLineSpacing: CGFloat = 10
    static let itemWidth = (UIScreen.main.bounds.width - Constants.leftDistanceToView - Constants.rightDistanceToView - (Constants.minimumLineSpacing))
}
