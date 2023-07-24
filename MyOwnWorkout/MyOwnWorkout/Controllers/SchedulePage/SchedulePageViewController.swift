//
//  SchedulePageViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 03.06.2023.
//

import UIKit

class SchedulePageViewController: GeneralViewController {

    @IBOutlet weak var schedulePageAvatar: UIImageView!
    @IBOutlet weak var schedulePageHeader: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        print("Вы перешли на страницу с расписанием")
    }
}
