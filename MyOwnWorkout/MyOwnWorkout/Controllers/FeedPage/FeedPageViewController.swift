//
//  FeedPageViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 03.06.2023.
//

import UIKit

class FeedPageViewController: GeneralViewController {

    @IBOutlet weak var feedPageAvatar: UIImageView!
    @IBOutlet weak var feedPageHeader: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupAvatarBounds(avatar: feedPageAvatar)
        tapAvatarOnTheRootPages(avatar: feedPageAvatar)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        feedPageAvatar.image = avatarImage
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
        feedPageAvatar.image = avatarImage
    }
}
