//
//  MyAchievmentsPageViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 12.08.2023.
//

import UIKit

class MyAchievmentsPageViewController: GeneralViewController {
    
    var presenter: MyAchievmentsPagePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Мои достижения"
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension MyAchievmentsPageViewController: MyAchievmentsPagePresenterDelegate {
    
}
