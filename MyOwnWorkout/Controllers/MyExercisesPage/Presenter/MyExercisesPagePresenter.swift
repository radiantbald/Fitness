//
//  MyExercisesPagePresenter.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 13.08.2023.
//

import Foundation
protocol MyExercisesPagePresenterDelegate: AnyObject {
    
}

final class MyExercisesPagePresenter {
    weak var delegate: MyExercisesPagePresenterDelegate?
    
    init(delegate: MyExercisesPagePresenterDelegate?) {
        self.delegate = delegate
    }
}

//MARK: - Input

extension MyExercisesPagePresenter {
    
}

//MARK: - Output

extension MyExercisesPagePresenter {
    
}
