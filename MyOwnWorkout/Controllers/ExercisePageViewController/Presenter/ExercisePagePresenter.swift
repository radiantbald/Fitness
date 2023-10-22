//
//  ExercisePagePresenter.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 22.10.2023.
//

import Foundation

protocol ExercisePagePresenterDelegate: AnyObject {
    
}

final class ExercisePagePresenter {
    
    weak var delegate: ExercisePagePresenterDelegate?
    init(delegate: ExercisePagePresenterDelegate?) {
        self.delegate = delegate
    }
}

//MARK: - Input

extension ExercisePagePresenter {
    
}

//MARK: - Output

extension ExercisePagePresenter {
    
}

