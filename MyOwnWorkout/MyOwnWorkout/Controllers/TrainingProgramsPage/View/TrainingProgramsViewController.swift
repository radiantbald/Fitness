//
//  TrainingProgramsViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 13.08.2023.
//

import UIKit

class TrainingProgramsPageViewController: GeneralViewController {
    
    var presenter: TrainingProgramsPagePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Программы тренировок"
        view.backgroundColor = .white
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension TrainingProgramsPageViewController: TrainingProgramsPagePresenterDelegate {
    
}
