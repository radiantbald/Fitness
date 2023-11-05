//
//  ExercisePagePresenter.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 21.10.2023.
//

import Foundation

protocol AddExercisePagePresenterDelegate: AnyObject {
    
}

final class AddExercisePagePresenter {
    
    weak var delegate: AddExercisePagePresenterDelegate?
    init(delegate: AddExercisePagePresenterDelegate?) {
        self.delegate = delegate
    }
}

//MARK: - Input

extension AddExercisePagePresenter {
    
}

//MARK: - Output

extension AddExercisePagePresenter {
    
}
