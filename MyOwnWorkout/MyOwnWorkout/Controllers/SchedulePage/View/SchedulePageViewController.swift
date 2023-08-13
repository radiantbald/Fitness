//
//  SchedulePageViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 03.06.2023.
//

import UIKit

class SchedulePageViewController: GeneralViewController {
    
    private let presenter = SchedulePagePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        setupNavigationBar()
        navigationItem.title = "Расписание"

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
}

extension SchedulePageViewController: SchedulePagePresenterDelegate {
    
}
