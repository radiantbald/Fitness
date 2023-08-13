//
//  MyExersisesPageViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 13.08.2023.
//

import UIKit

class MyExercisesPageViewController: GeneralViewController {
    
    private let presenter = MyExercisesPagePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        navigationItem.title = "Мои упражнения"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension MyExercisesPageViewController: MyExercisesPagePresenterDelegate {
    
}
