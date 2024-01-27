//
//  MyWorkoutsPagePresenter.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 13.08.2023.
//

import Foundation
protocol MyWorkoutsPagePresenterDelegate: AnyObject {
    
}

final class MyWorkoutsPagePresenter {
    
    weak var delegate: MyWorkoutsPagePresenterDelegate?
    init(delegate: MyWorkoutsPagePresenterDelegate?) {
        self.delegate = delegate
    }
}

//MARK: - Input

extension MyWorkoutsPagePresenter {
    
}

//MARK: - Output

extension MyWorkoutsPagePresenter {
    
}
