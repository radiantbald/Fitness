//
//  ScheduleViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 24.05.2023.
//

import UIKit

class PersonPageViewController: GeneralViewController {

    private let presenter = PersonPagePresenter()
    
    private var menu = UIMenu()
    
    private lazy var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var personPageAvatar: UIImageView!
    @IBOutlet weak var personPageName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self

        setupAvatarAction()
        setupMenuAction()
        navigationItem.backButtonTitle = "Назад"
        navigationItem.title = "Мой кабинет"
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), menu: menu)
        
        print("Вы перешли в Личный кабинет")
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
    
    func saveUserAvatarImageAction(_ image: UIImage) {
        personPageAvatar.image = image
        avatarImage = image
    }
    
    private func setupAvatarAction() {
        presenter.setupAvatar()
    }
    
    @objc private func avatarTapAction() {
        presenter.avatarTap()
    }
    
    private func setupMenuAction() {
        presenter.setupMenu()
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

    func setupAvatar() {
        
        personPageAvatar.image = avatarImage
        setupAvatarBounds(avatar: personPageAvatar)
        
        imagePicker.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarTapAction))
        tapGesture.delegate = self
        personPageAvatar.superview?.addGestureRecognizer(tapGesture)
        
    }
    
    func avatarTap() {
        
        let actionImage = UIAlertController(title: "Сменить аватарку", message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Камера", style: .default) { _ in
            self.imagePicker.sourceType = .camera
        }
        
        let photoLibrary = UIAlertAction(title: "Фотоальбом", style: .default) { _ in
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.allowsEditing = true
            self.navigationController?.present(self.imagePicker, animated:true)
        }
        
//        let buffer = UIAlertAction(title: "Вставить из буфера", style: .default) { _ in
//            if let image = UIPasteboard.general.image {
//                self.saveUserAvatarImage(image)
//            }
//        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        actionImage.addAction(camera)
        actionImage.addAction(photoLibrary)
//        actionImage.addAction(buffer)
        actionImage.addAction(cancel)
        
        if let popover = actionImage.popoverPresentationController {
            popover.sourceView = self.view
            let frame = view.frame
            popover.sourceRect = CGRect(x: frame.midX, y: frame.maxY, width: 1.0, height: 1.0)
        }
        present(actionImage, animated: true)
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
        
        menu = UIMenu(title: "Меню", children: [trainingPrograms, myWorkouts, myExercises, myAchievments, personalAccount, settings, aboutApp, exit])
    }
    
    func openTrainingProgramsPage() {
        guard let viewController = TrainigProgramsPageViewController.storyboardInit else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func openMyWorkoutsPage() {
        guard let viewController = MyWorkoutsPageViewController.storyboardInit else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func openMyExercisesPage() {
        guard let viewController = MyExercisesPageViewController.storyboardInit else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func openMyAchievmentsPage() {
        guard let viewController = MyAchievmentsPageViewController.storyboardInit else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func openPersonalAccountPage() {
        guard let viewController = PersonalAccountPageViewController.storyboardInit else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func openSettingsPage() {
        guard let viewController = SettingsPageViewController.storyboardInit else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func openAboutAppPage() {
        guard let viewController = AboutAppPageViewController.storyboardInit else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func exit() {
        navigationController?.popToRootViewController(animated: true)
    }
}


