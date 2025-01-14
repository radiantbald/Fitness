//
//  PersonalAccountPagePresenter.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 12.08.2023.
//

import Foundation

protocol PersonalAccountPagePresenterDelegate: AnyObject {
    
}

final class PersonalAccountPagePresenter {
    
    weak var delegate: PersonalAccountPagePresenterDelegate?
    init(delegate: PersonalAccountPagePresenterDelegate?) {
        self.delegate = delegate
    }
}

//MARK: - Input

extension PersonalAccountPagePresenter {
    
}

//MARK: - Output

extension PersonalAccountPagePresenter {
    
}


