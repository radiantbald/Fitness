//
//  SetupExercisePagePresenter.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 11.12.2023.
//

import Foundation

protocol SetupExercisePagePresenterDelegate: AnyObject {
    
}

final class SetupExercisePagePresenter {
    
    weak var delegate: SetupExercisePagePresenterDelegate?
    init(delegate: SetupExercisePagePresenterDelegate?) {
        self.delegate = delegate
    }
}

//MARK: - Input

extension SetupExercisePagePresenter {
    
}

//MARK: - Output

extension SetupExercisePagePresenter {
    
}
