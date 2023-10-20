//
//  ExerciseModel.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 17.10.2023.
//

import Foundation

class ExerciseModel: NSObject, NSCoding {
    public var exerciseName: String
    public var muscleGroup: String
    
    func encode(with coder: NSCoder) {
        coder.encode(exerciseName, forKey: "exerciseName")
        coder.encode(muscleGroup, forKey: "muscleGroup")
    }
    
    required init?(coder: NSCoder) {
        self.exerciseName = coder.decodeObject(forKey: "exerciseName") as! String
        self.muscleGroup = coder.decodeObject(forKey: "muscleGroup") as! String
    }
    
    
}
