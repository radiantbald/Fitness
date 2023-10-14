//
//  TrainingProgramsPresenter.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 13.08.2023.
//

import Foundation

protocol TrainingProgramsPagePresenterDelegate: AnyObject {
    
}

final class TrainingProgramsPagePresenter {
    weak var delegate: TrainingProgramsPagePresenterDelegate?
    init(delegate: TrainingProgramsPagePresenterDelegate?) {
        self.delegate = delegate
    }
}

//MARK: - Input

extension TrainingProgramsPagePresenter {
    
}

//MARK: - Output

extension TrainingProgramsPagePresenter {
    
}
