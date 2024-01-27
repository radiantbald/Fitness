//
//  WorkoutPageViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 27.01.2024.
//

import Foundation

protocol WorkoutPageViewControllerDelegate: AnyObject {
    func reloadTableViewData()
}

class WorkoutPageViewController: GeneralViewController {
    
    var presenter: WorkoutPagePresenter!
    var workout: WorkoutModel!
    
    weak var delegate: WorkoutPageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension WorkoutPageViewController: WorkoutPagePresenterDelegate {
    
}
