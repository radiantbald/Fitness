//
//  AboutAppPage.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 12.08.2023.
//

import UIKit

class AboutAppPageViewController: GeneralViewController {
    
    var presenter: AboutAppPagePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "О приложении"
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension AboutAppPageViewController: AboutAppPagePresenterDelegate {
    
}

