//
//  MyWorkoutsPageViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 13.08.2023.
//

import UIKit

class MyWorkoutsPageViewController: GeneralViewController {
    
    var presenter: MyWorkoutsPagePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Мои тренировки"
        view.backgroundColor = .white
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
