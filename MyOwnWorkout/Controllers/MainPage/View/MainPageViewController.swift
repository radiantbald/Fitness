//
//  ViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 20.05.2023.
//

import UIKit

class MainPageViewController: GeneralViewController {

    var presenter: MainPagePresenter!
    
    let mainPageAvatar = UIImageView(75, 75)
    let mainPageHeader =  UILabel("Личный кабинет", UIFont(name: Fonts.main.rawValue, size: 20.0)!, .black)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        mainPageDesign()
        mainPageActions()
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
        
        let allHeaderItemsHStackView = UIStackView.init([mainPageAvatar, mainPageHeader], .horizontal, 0, .center, .equalCentering)
        view.addSubviews(allHeaderItemsHStackView)

        let margins = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            allHeaderItemsHStackView.topAnchor.constraint(greaterThanOrEqualTo: margins.topAnchor, constant: 10),
            allHeaderItemsHStackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
            allHeaderItemsHStackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            allHeaderItemsHStackView.heightAnchor.constraint(lessThanOrEqualToConstant: mainPageAvatar.frame.size.height),
            
            mainPageAvatar.widthAnchor.constraint(equalToConstant: mainPageAvatar.frame.size.height),
            
            mainPageHeader.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
            mainPageHeader.leadingAnchor.constraint(equalTo: mainPageAvatar.trailingAnchor, constant: 10)
        ])
    }
    
    private func mainPageActions() {
        setupAvatarBounds(mainPageAvatar)
        tapAndGoToPersonPage(mainPageAvatar)
        tapAndGoToPersonPage(mainPageHeader)
    }
}

//MARK: - Настройка кнопки-аватарки

extension MainPageViewController {
    
    func tapAndGoToPersonPage(_ tapAreas: UIView...) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goToPersonPageButton))
        tapGesture.delegate = self
        tapAreas.forEach({ tapArea in
            tapArea.isUserInteractionEnabled = true
            tapArea.addGestureRecognizer(tapGesture)
        })
        // ??? как сделать массив, чтоб в параметрах работали все UIView, а не только последний в очереди
    }
    
    @objc func goToPersonPageButton() {
        
        if isAuth || doNotUseAuth {
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
