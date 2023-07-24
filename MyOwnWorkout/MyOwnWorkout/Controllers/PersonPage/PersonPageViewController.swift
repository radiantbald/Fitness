//
//  ScheduleViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 24.05.2023.
//

import UIKit

class PersonPageViewController: GeneralViewController {
    
    @IBOutlet weak var personPageAvatar: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        personPageAvatar.layer.cornerRadius = personPageAvatar.frame.size.width/2
        personPageAvatar.frame = CGRectMake(30, 100, 100, 100)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = true
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Личный кабинет"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Выйти", style: .plain, target: self, action: #selector(exit))
        print("Вы перешли в Личный кабинет")
    }
    @objc private func exit() {
        isAuth = false
        print("Вы вышли из аккаунта")
        navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }

}
