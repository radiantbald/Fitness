//
//  ExerciseModel.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 17.10.2023.
//

import Foundation

class ExerciseModel: NSObject, NSCoding {
    public var exerciseName: String
    
    func encode(with coder: NSCoder) {
        coder.encode(exerciseName, forKey: "exerciseName")
    }
    
    required init?(coder: NSCoder) {
        self.exerciseName = coder.decodeObject(forKey: "exerciseName") as! String
    }
    
    
}
