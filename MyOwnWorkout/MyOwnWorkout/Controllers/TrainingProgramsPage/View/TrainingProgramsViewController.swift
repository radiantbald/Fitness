//
//  TrainingProgramsViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 13.08.2023.
//

import UIKit

class TrainigProgramsPageViewController: GeneralViewController {
    
    private let presenter = TrainingProgramsPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        navigationItem.title = "Программы тренировок"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension TrainigProgramsPageViewController: TrainingProgramsPresenterDelegate {
    
}
