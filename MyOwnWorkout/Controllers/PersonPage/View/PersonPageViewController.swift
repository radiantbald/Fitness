//
//  ScheduleViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 24.05.2023.
//

import UIKit

class PersonPageViewController: GeneralViewController {

    var presenter: PersonPagePresenter!
    
    private lazy var imagePicker = UIImagePickerController()
    
    private let personPageAvatar = UIImageView(75, 75)
    private let personPageName = UILabel("Олег Попов", UIFont(name: Fonts.mainBold.rawValue, size: 20.0)!, .black)
    private let personPageNickname = UILabel("@nickname", UIFont(name: Fonts.main.rawValue, size: 15.0)!, .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        personPageDesign()
        personPageActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
}

extension PersonPageViewController {
    
    func personPageDesign() {
        
        navigationItem.title = "Мой кабинет"
        navigationItem.backButtonTitle = "Назад"
        
        let headerLabelsVStackView = UIStackView.init([personPageName, personPageNickname], .vertical, 0, .fill, .equalCentering)
        let allHeaderItemsHStackView = UIStackView.init([personPageAvatar, headerLabelsVStackView], .horizontal, 0, .center, .equalCentering)
        
        view.addSubviews(allHeaderItemsHStackView)
        
        let margins = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            allHeaderItemsHStackView.topAnchor.constraint(greaterThanOrEqualTo: margins.topAnchor, constant: 10),
            allHeaderItemsHStackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
            allHeaderItemsHStackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -10),
            allHeaderItemsHStackView.heightAnchor.constraint(lessThanOrEqualToConstant: personPageAvatar.frame.size.height),
            
            headerLabelsVStackView.leadingAnchor.constraint(equalTo: personPageAvatar.trailingAnchor, constant: 10),
            
            personPageAvatar.widthAnchor.constraint(equalToConstant: personPageAvatar.frame.size.height),
            
            personPageName.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
            
            personPageNickname.heightAnchor.constraint(greaterThanOrEqualToConstant: 20)
        ])
    }
    
    func personPageActions() {
        setupAvatar()
        setupMenu()
    }
}

extension PersonPageViewController {
    
    func setupAvatar() {
        
        personPageAvatar.image = avatarImage
        setupAvatarBounds(personPageAvatar)
        
        imagePicker.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarTap))
        tapGesture.delegate = self
        personPageAvatar.isUserInteractionEnabled = true
        personPageAvatar.addGestureRecognizer(tapGesture)
    }
    
    @objc func avatarTap() {
        
        let actionImage = UIAlertController(title: "Сменить аватарку", message: nil, preferredStyle: .actionSheet)
        
//        let camera = UIAlertAction(title: "Камера", style: .default) { _ in
//            self.imagePicker.sourceType = .camera
//            self.imagePicker.cameraDevice = .front
//            self.imagePicker.allowsEditing = true
//            self.navigationController?.present(self.imagePicker, animated: true)
//        }
        
        let photoLibrary = UIAlertAction(title: "Фотоальбом", style: .default) { _ in
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.allowsEditing = true
            self.navigationController?.present(self.imagePicker, animated:true)
        }
        
//        let buffer = UIAlertAction(title: "Вставить из буфера", style: .default) { _ in
//            if let image = UIPasteboard.general.image {
//                self.saveUserAvatarImageAction(image)
//            }
//        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        
//        actionImage.addAction(camera)
        actionImage.addAction(photoLibrary)
//        actionImage.addAction(buffer)
        actionImage.addAction(cancel)
        
        if let popover = actionImage.popoverPresentationController {
            popover.sourceView = self.view
            let frame = view.frame
            popover.sourceRect = CGRect(x: frame.midX, y: frame.maxY, width: 1.0, height: 1.0)
        }
        self.present(actionImage, animated: true)
    }
    
    func setupMenu() {
        
        let trainingPrograms = UIAction(title: "Программы тренировок", handler: { _ in self.openTrainingProgramsPageAction()})
        let myWorkouts = UIAction(title: "Мои тренировки", handler: { _ in self.openMyWorkoutsPageAction()})
        let myExercises = UIAction(title: "Мои упражнения", handler: { _ in self.openMyExercisesPageAction()})
        let myAchievments = UIAction(title: "Мои достижения", image: UIImage(systemName: "star"), handler: { _ in self.openMyAchievmentsPageAction()})
        let personalAccount = UIAction(title: "Лицевой счет",image: UIImage(systemName: "banknote"), handler: { _ in self.openPersonalAccountPageAction()})
        let settings = UIAction(title: "Настройки", image: UIImage(systemName: "gear"), handler: { _ in self.openSettingsPageAction()})
        let aboutApp = UIAction(title: "О приложении",image: UIImage(systemName: "apple.logo"), handler: { _ in self.openAboutPagePageAction()})
        let exit = UIAction(title: "Выход", image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), attributes: .destructive, handler: { _ in self.exitAction()})
        
        let menu = UIMenu(title: "Меню", children: [trainingPrograms, myWorkouts, myExercises, myAchievments, personalAccount, settings, aboutApp, exit])
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), menu: menu)
    }
    
    private func openTrainingProgramsPageAction() {
        presenter.openTrainingProgramsPage()
    }
    
    private func openMyWorkoutsPageAction() {
        presenter.openMyWorkoutsPage()
    }
    
    private func openMyExercisesPageAction() {
        presenter.openMyExercisesPage()
    }
    
    private func openMyAchievmentsPageAction() {
        presenter.openMyAchievmentsPage()
    }
    
    private func openPersonalAccountPageAction() {
        presenter.openPersonalAccountPage()
    }
    
    private func openSettingsPageAction() {
        presenter.openSettingsPage()
    }
    
    private func openAboutPagePageAction() {
        presenter.openAboutAppPage()
    }
    
    private func exitAction() {
        presenter.exit()
    }
    
    func saveUserAvatarImageAction(_ image: UIImage) {
        personPageAvatar.image = image
        avatarImage = image
    }
}

extension PersonPageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.saveUserAvatarImageAction(pickedImage)
            dismiss(animated: true)
        }
    }
}
//MARK: - Делегаты презентера

extension PersonPageViewController: PersonPagePresenterDelegate {

    func openTrainingProgramsPage() {
        let viewController = Assembler.controllers.trainingProgramsPageViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func openMyWorkoutsPage() {
        let viewController = Assembler.controllers.myWorkoutsPageViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func openMyExercisesPage() {
        let viewController = Assembler.controllers.myExercisesPageViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func openMyAchievmentsPage() {
        let viewController = Assembler.controllers.myAchievmentsPageViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func openPersonalAccountPage() {
        let viewController = Assembler.controllers.personalAccountPageViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func openSettingsPage() {
        let viewController = Assembler.controllers.settingsPageViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func openAboutAppPage() {
        let viewController = Assembler.controllers.aboutAppPageViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func exit() {
        navigationController?.popToRootViewController(animated: true)
    }
}


