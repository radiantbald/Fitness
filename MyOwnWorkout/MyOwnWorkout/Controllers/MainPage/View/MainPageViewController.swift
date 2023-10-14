//
//  ViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 20.05.2023.
//

import UIKit

class MainPageViewController: GeneralViewController {
    
    var presenter: MainPagePresenter!
    
    var mainPageAvatar: UIImageView = {
        let mainPageAvatar = UIImageView()
        mainPageAvatar.translatesAutoresizingMaskIntoConstraints = false
        return mainPageAvatar
    }()
    var mainPageHeader: UILabel = {
        let mainPageHeader = UILabel()
        mainPageHeader.translatesAutoresizingMaskIntoConstraints = false
        return mainPageHeader
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        mainPageDesign()
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

extension MainPageViewController {
    
    private func mainPageDesign() {
        
        navigationItem.title = "Главная"
        navigationItem.backButtonTitle = "На главную"
        
        view.addSubview(mainPageAvatar)
        view.addSubview(mainPageHeader)
        
        mainPageAvatar.frame.size.width = 75
        mainPageAvatar.frame.size.height = mainPageAvatar.frame.size.width
        
        mainPageHeader.text = "Личный кабинет"
        mainPageHeader.baselineAdjustment = .alignCenters
        
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            mainPageAvatar.heightAnchor.constraint(equalToConstant: mainPageAvatar.frame.size.width),
            mainPageAvatar.widthAnchor.constraint(equalToConstant: mainPageAvatar.frame.size.height),
            mainPageAvatar.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10),
            mainPageAvatar.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10),
            
            mainPageHeader.heightAnchor.constraint(equalToConstant: mainPageAvatar.frame.size.height),
            mainPageHeader.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10),
            mainPageHeader.leadingAnchor.constraint(equalTo: mainPageAvatar.trailingAnchor, constant: 10),
            mainPageHeader.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -10)
        ])
    }
}

//MARK: - Настройка кнопки-аватарки

extension MainPageViewController {
    
    func tapAvatarOnTheMainPage(avatar: UIImageView) {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarButton))
        tapGesture.delegate = self
        avatar.isUserInteractionEnabled = true
        avatar.addGestureRecognizer(tapGesture)
    }
    
    @objc func avatarButton() {
        
        if isAuth {
            let viewController = Assembler.controllers.personPageViewController
            viewController.modalPresentationStyle = .overFullScreen
            navigationController?.pushViewController(viewController, animated: true)
        } else {
            let viewController = Assembler.controllers.entryPageViewController
            viewController.modalPresentationStyle = .overFullScreen
            viewController.delegate = self
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

//MARK: - EntryPageViewControllerDelegate

extension MainPageViewController: EntryPageViewControllerDelegate {
    func getSMSCodeAndOpenApprovePage(phoneNumber: String) {
        presenter.sendPhoneNumberAction(phoneNumber)
    }
}

//MARK: - SMSCodeApprovePageViewControllerDelegate

extension MainPageViewController: SMSCodeApprovePageViewControllerDelegate {
    func authApprove() {
        let viewController = Assembler.controllers.personPageViewController
        navigationController?.pushViewController(viewController, animated: false)
    }
}

//MARK: - Делегат презентера

extension MainPageViewController: MainPagePresenterDelegate {
    
    //MARK: - пересыл номера телефона с EntryPage на SMSCodeApprovePage
    
    func sendPhoneNumber(_ phoneNumber: String) {
        let viewController = Assembler.controllers.smsCodeApprovePageViewController
        viewController.delegate = self
        viewController.sentPhoneNumber = phoneNumber
        navigationController?.pushViewController(viewController, animated: false)
    }
    
    func showAuthAlert(error: Error) {
        showAlert(title: "Ошибка", message: error.localizedDescription)
    }
}
