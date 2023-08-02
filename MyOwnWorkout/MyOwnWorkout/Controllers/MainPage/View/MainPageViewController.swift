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
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var testButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        setupNavigationBar()
        setupAvatarBounds(avatar: mainPageAvatar)
        tapAvatarOnTheRootPages(avatar: mainPageAvatar)
        testButton.addTarget(self, action: #selector(testButtonAction(_:)), for: .touchUpInside)
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
    
    @objc private func testButtonAction(_ sender: UIButton) {
        presenter.selectOrangeButton()
    }
}


//MARK: - Presenter Delegate
extension MainPageViewController: MainPagePresenterDelegate {
    func getNumber(_ number: Int) {
        testLabel.text = String(number)
    }
}
