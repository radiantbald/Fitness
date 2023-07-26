//
//  ViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 20.05.2023.
//

import UIKit

class MainPageViewController: GeneralViewController {

    @IBOutlet weak var mainPageAvatar: UIImageView!
    @IBOutlet weak var mainPageHeader: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        print("Вы перешли на Главную страницу")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
        mainPageAvatar.image = avatarImage
        mainPageAvatar.clipsToBounds = true
        mainPageAvatar.contentMode = .scaleAspectFill
        let frame = mainPageAvatar.frame
        let height = min(frame.height, frame.width)
        mainPageAvatar.layer.cornerRadius = height / 2
    }
}
