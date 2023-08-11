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

        setupAvatar()
        setupMenu()
        navigationItem.backButtonTitle = "Назад"
        navigationItem.title = "Личный кабинет"
       
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

extension PersonPageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.saveUserAvatarImage(pickedImage)
            dismiss(animated: true)
        }
    }
}

extension PersonPageViewController {
    
    func saveUserAvatarImage(_ image: UIImage) {
        personPageAvatar.image = image
        avatarImage = image
    }
    
    func setupAvatar() {
        personPageAvatar.image = avatarImage
        setupAvatarBounds(avatar: personPageAvatar)
        
        imagePicker.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarTapAction))
        tapGesture.delegate = self
        personPageAvatar.superview?.addGestureRecognizer(tapGesture)
    }
    
    @objc private func avatarTapAction() {
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
        
        let trainingPrograms = UIAction(title: "Программы тренировок", attributes: .disabled, handler: { _ in })
        
        let myWorkouts = UIAction(title: "Мои тренировки", attributes: .disabled, handler: { _ in })
     
        let myExercises = UIAction(title: "Мои упражнения", attributes: .disabled, handler: { _ in })
        
        let myAchievments = UIAction(title: "Мои достижения", image: UIImage(systemName: "star"), attributes: .disabled, handler: { _ in })
        
        let personalAccount = UIAction(title: "Лицевой счет",image: UIImage(systemName: "banknote"),  attributes: .disabled, handler: { _ in })
        
        let settings = UIAction(title: "Настройки", image: UIImage(systemName: "gear"), handler: { _ in self.openSettingsPage()})
        
        let aboutApp = UIAction(title: "О приложении",image: UIImage(systemName: "apple.logo"),  attributes: .disabled, handler: { _ in })
        
        let exit = UIAction(title: "Выход", image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), attributes: .destructive, handler: { _ in self.exitAction()})
        
        menu = UIMenu(title: "Меню", children: [trainingPrograms, myWorkouts, myExercises, myAchievments, personalAccount, settings, aboutApp, exit])
    }
    
    @objc private func openSettingsPage() {
        guard let viewController = SettingsPageViewController.storyboardInit else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func exitAction() {
        presenter.exit()
        navigationController?.popToRootViewController(animated: true)
    }
}

extension PersonPageViewController: PersonPagePresenterDelegate {

}


