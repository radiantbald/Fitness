//
//  ExerciseImagesTilePresenter.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 30.12.2023.
//

import Foundation

protocol ExerciseImagesTilePresenterDelegate: AnyObject {
    
}

final class ExerciseImagesTilePresenter {
    
    weak var delegate: ExerciseImagesTilePresenterDelegate?
    init(delegate: ExerciseImagesTilePresenterDelegate?) {
        self.delegate = delegate
    }
}

//MARK: - Input

extension ExerciseImagesTilePresenter {
    
}

//MARK: - Output

extension ExerciseImagesTilePresenter {
    
}
