//
//  ExerciseImageViewerViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 04.01.2024.
//

import UIKit

protocol ExerciseImageViewerViewControllerDelegate: AnyObject {
}

final class ExerciseImageViewerViewController: GeneralViewController {
    
    var presenter: ExerciseImageViewerPresenter!
    private weak var delegate: ExerciseImageViewerViewControllerDelegate?
    
    init(parent: ExerciseImageViewerViewControllerDelegate? = nil) {
        self.delegate = parent
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ExerciseImageViewerViewController: ExerciseImageViewerPresenterDelegate {
    
}
