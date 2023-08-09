//
//  PersonPagePresenter.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 05.08.2023.
//

import Foundation

protocol PersonPagePresenterDelegate: AnyObject {

}

final class PersonPagePresenter {

    weak var delegate: PersonPagePresenterDelegate?
    
    private func exitAction() {
        DataBase.isAuth = false
        print("Вы вышли из аккаунта")
    }

}

//MARK: - Input

extension PersonPagePresenter {
    func exit() {
        exitAction()
    }
}

//MARK: - Output

extension PersonPagePresenter {

}
