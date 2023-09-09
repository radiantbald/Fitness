//
//  FeedPagePresenter.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 05.08.2023.
//

import Foundation

protocol FeedPagePresenterDelegate: AnyObject {
    
}

final class FeedPagePresenter {
    weak var delegate: FeedPagePresenterDelegate?
    
    init(delegate: FeedPagePresenterDelegate? = nil) {
        self.delegate = delegate
    }
}

//MARK: - Input

extension FeedPagePresenter {
    
}

//MARK: - Output

extension FeedPagePresenter {
    
}
