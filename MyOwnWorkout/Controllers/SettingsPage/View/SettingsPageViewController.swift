//
//  SettingsPageViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 10.08.2023.
//

import UIKit

class SettingsPageViewController: GeneralViewController {
    
    var presenter: SettingsPagePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Настройки"
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension SettingsPageViewController: SettingsPagePresenterDelegate {
    
}
