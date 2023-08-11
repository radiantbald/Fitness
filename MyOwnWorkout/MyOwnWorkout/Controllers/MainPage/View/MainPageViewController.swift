//
//  ViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 20.05.2023.
//

import UIKit

class MainPageViewController: GeneralViewController {
    
    private let presenter = MainPagePresenter()

    @IBOutlet weak var mainPageAvatar: UIImageView!
    @IBOutlet weak var mainPageHeader: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        presenter.delegate = self
        setupNavigationBar()
        navigationItem.title = "Главная"
        navigationItem.backButtonTitle = "На главную"
        setupAvatarBounds(avatar: mainPageAvatar)
        tapAvatarOnTheMainPage(avatar: mainPageAvatar)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        mainPageAvatar.image = avatarImage
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
        mainPageAvatar.image = avatarImage
        
    }
}

//MARK: - Настройка кнопки-аватарки

extension MainPageViewController {
    
    func tapAvatarOnTheMainPage(avatar: UIImageView) {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarButton))
        tapGesture.delegate = self
        avatar.superview?.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func avatarButton() {
        
        if isAuth {
            
            guard let viewController = PersonPageViewController.storyboardInit else { return }
            viewController.modalPresentationStyle = .overFullScreen
            navigationController?.pushViewController(viewController, animated: true)
            
        } else {
            
            guard let viewController = EntryPageViewController.storyboardInit else { return }
            viewController.modalPresentationStyle = .overFullScreen
            viewController.delegate = self
            navigationController?.pushViewController(viewController, animated: true)
            
        }
    }
}

//MARK: - Делегат презентера

extension MainPageViewController: MainPagePresenterDelegate {
    
}
