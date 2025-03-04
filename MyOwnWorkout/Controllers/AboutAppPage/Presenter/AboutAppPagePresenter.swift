//
//  AboutAppPagePresenter.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 12.08.2023.
//

import Foundation

protocol AboutAppPagePresenterDelegate: AnyObject {
    
}

final class AboutAppPagePresenter {
    
    weak var delegate: AboutAppPagePresenterDelegate?
    init(delegate: AboutAppPagePresenterDelegate?) {
        self.delegate = delegate
    }
}

//MARK: - Input

extension AboutAppPagePresenter {
    
}

//MARK: - Output

extension AboutAppPagePresenter {
    
}

