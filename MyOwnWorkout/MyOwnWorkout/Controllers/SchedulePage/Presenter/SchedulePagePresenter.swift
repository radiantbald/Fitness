//
//  SchedulePagePresenter.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 05.08.2023.
//

import Foundation

protocol SchedulePagePresenterDelegate: AnyObject {
    
}

final class SchedulePagePresenter {
    weak var delegate: SchedulePagePresenterDelegate?
    
    init(delegate: SchedulePagePresenterDelegate? = nil) {
        self.delegate = delegate
    }
}

//MARK: - Input

extension SchedulePagePresenter {
    
}

//MARK: - Output

extension SchedulePagePresenter {
    
}
