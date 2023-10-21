//
//  ExercisePagePresenter.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 21.10.2023.
//

import Foundation

protocol ExerciseSetupPagePresenterDelegate: AnyObject {
    
}

final class ExerciseSetupPagePresenter {
    
    weak var delegate: ExerciseSetupPagePresenterDelegate?
    init(delegate: ExerciseSetupPagePresenterDelegate?) {
        self.delegate = delegate
    }
}

//MARK: - Input

extension ExerciseSetupPagePresenter {
    
}

//MARK: - Output

extension ExerciseSetupPagePresenter {
    
}
