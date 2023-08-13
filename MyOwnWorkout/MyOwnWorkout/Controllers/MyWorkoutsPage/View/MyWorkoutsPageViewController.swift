//
//  MyWorkoutsPageViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 13.08.2023.
//

import UIKit

class MyWorkoutsPageViewController: GeneralViewController {
    
    private let presenter = MyWorkoutsPagePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        navigationItem.title = "Мои тренировки"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension MyWorkoutsPageViewController: MyWorkoutsPagePresenterDelegate {
    
}
