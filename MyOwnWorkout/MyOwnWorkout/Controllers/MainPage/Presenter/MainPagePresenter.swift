//
//  MainPagePresenter.swift
//  MyOwnWorkout
//
//  Created by Алмаз Рахматуллин on 02.08.2023.
//

import Foundation

final class MainPagePresenter {
    weak var delegate: MainPagePresenterDelegate?
    private var select: Int = 0
    private var max: Int = 12
    
    private func addResultForSelect() {
        if DataBase.isAuth { return }
        select += 1
        if max < select {
            select = 0
        }
        getForNumber(value: select)
    }
}



//MARK: - Input ///тут методы которые будут приходить в Presenter
extension MainPagePresenter {
    func selectOrangeButton() {
        addResultForSelect()
    }
}




//MARK: - Output ///тут методы которые будут уходить из Presenter
extension MainPagePresenter {
    private func getForNumber(value: Int) {
        delegate?.getNumber(value)
    }
}
