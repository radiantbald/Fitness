//
//  EntryPageViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 03.06.2023.
//

import UIKit

class EntryPageViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Вход"
        print("Вы перешли на страницу авторизации")
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }
}
