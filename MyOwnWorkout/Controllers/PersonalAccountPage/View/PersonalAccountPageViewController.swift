//
//  PersonalAccountPageViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 12.08.2023.
//

import UIKit

class PersonalAccountPageViewController: GeneralViewController {
    
    var presenter: PersonalAccountPagePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Лицевой счет"
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension PersonalAccountPageViewController: PersonalAccountPagePresenterDelegate {
    
}


