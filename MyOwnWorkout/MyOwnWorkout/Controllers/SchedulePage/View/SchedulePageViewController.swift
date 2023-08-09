//
//  SchedulePageViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 03.06.2023.
//

import UIKit

class SchedulePageViewController: GeneralViewController {
    
    private let presenter = SchedulePagePresenter()

    @IBOutlet weak var schedulePageAvatar: UIImageView!
    @IBOutlet weak var schedulePageHeader: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupAvatarBounds(avatar: schedulePageAvatar)
        tapAvatarOnTheRootPages(avatar: schedulePageAvatar)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        schedulePageAvatar.image = avatarImage
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
        schedulePageAvatar.image = avatarImage
    }
}

extension SchedulePageViewController: SchedulePagePresenterDelegate {
    
}
