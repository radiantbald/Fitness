//
//  EntryPagePresenter.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 05.08.2023.
//

import Foundation

protocol EntryPagePresenterDelegate: AnyObject {

}

final class EntryPagePresenter {
    weak var delegate: EntryPagePresenterDelegate?
    init(delegate: EntryPagePresenterDelegate?) {
        self.delegate = delegate
    }
}

//MARK: - Input

extension EntryPagePresenter {

}

//MARK: - Output

extension EntryPagePresenter {

}
