//
//  ExerciseImageViewerPresenter.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 04.01.2024.
//

import Foundation

protocol ExerciseImageViewerPresenterDelegate: AnyObject {
    
}

final class ExerciseImageViewerPresenter {
    
    weak var delegate: ExerciseImageViewerPresenterDelegate?
    init(delegate: ExerciseImageViewerPresenterDelegate?) {
        self.delegate = delegate
    }
}

//MARK: - Input

extension ExerciseImageViewerPresenter {
    
}

//MARK: - Output

extension ExerciseImageViewerPresenter {
    
}
