//
//  SettingsPagePresenter.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 10.08.2023.
//

import Foundation

protocol SettingsPagePresenterDelegate: AnyObject {
    
}

final class SettingsPagePresenter {
    
    weak var delegate: SettingsPagePresenterDelegate?
    init(delegate: SettingsPagePresenterDelegate?) {
        self.delegate = delegate
    }
}

//MARK: - Input

extension SettingsPagePresenter {
    
}

//MARK: - Output

extension SettingsPagePresenter {
    
}
