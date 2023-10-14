//
//  MyAchievmentsPagePresenter.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 12.08.2023.
//

import Foundation

protocol MyAchievmentsPagePresenterDelegate: AnyObject {
    
}

final class MyAchievmentsPagePresenter {
    
    weak var delegate: MyAchievmentsPagePresenterDelegate?
    init(delegate: MyAchievmentsPagePresenterDelegate?) {
        self.delegate = delegate
    }
}

//MARK: - Input

extension MyAchievmentsPagePresenter {
    
}

//MARK: - Output

extension MyAchievmentsPagePresenter {
    
}
