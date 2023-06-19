//
//  SchedulePageViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 03.06.2023.
//

import UIKit

class SchedulePageViewController: UIViewController {

    var isAuth: Bool = true
    
    @IBOutlet weak var schedulePageAvatar: UIImageView!
    @IBOutlet weak var schedulePageHeader: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
        print("Вы перешли на страницу с расписанием")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func avatarButton(_ sender: UIButton) {
        
        if isAuth {
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "PersonPageViewController") as! PersonPageViewController
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "RegistrationPageViewController") as! RegistrationPageViewController
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}
