//
//  WorkoutPagePresenter.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 27.01.2024.
//

import Foundation
protocol WorkoutPagePresenterDelegate: AnyObject {
    
}

final class WorkoutPagePresenter {
    
    weak var delegate: WorkoutPagePresenterDelegate?
    init(delegate: WorkoutPagePresenterDelegate?) {
        self.delegate = delegate
    }
}

//MARK: - Input

extension WorkoutPagePresenter {
    
}

//MARK: - Output

extension WorkoutPagePresenter {
    
}
