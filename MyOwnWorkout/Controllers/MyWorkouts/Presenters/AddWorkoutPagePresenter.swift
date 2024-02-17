//
//  AddWorkoutPagePresenter.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 17.02.2024.
//

import Foundation

protocol AddWorkoutPagePresenterDelegate: AnyObject {
    
}

final class AddWorkoutPagePresenter {
    
    weak var delegate: AddWorkoutPagePresenterDelegate?
    init(delegate: AddWorkoutPagePresenterDelegate?) {
        self.delegate = delegate
    }
}

//MARK: - Input

extension AddWorkoutPagePresenter {
    
}

//MARK: - Output

extension AddWorkoutPagePresenter {
    
}
