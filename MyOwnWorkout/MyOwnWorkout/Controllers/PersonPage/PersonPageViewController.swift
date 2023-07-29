//
//  ScheduleViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 24.05.2023.
//

import UIKit

class PersonPageViewController: GeneralViewController {
    
    private lazy var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var personPageAvatar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Личный кабинет"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Выйти", style: .plain, target: self, action: #selector(exit))
        print("Вы перешли в Личный кабинет")
        
        imagePicker.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarTapAction))
        tapGesture.delegate = self
        personPageAvatar.superview?.addGestureRecognizer(tapGesture)
        
        personPageAvatar.image = avatarImage
        setupAvatarBounds(avatar: personPageAvatar)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    @objc private func exit() {
        isAuth = false
        print("Вы вышли из аккаунта")
        navigationController?.popToRootViewController(animated: true)
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
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func saveUserAvatarImage(_ image: UIImage) {
        personPageAvatar.image = image
        avatarImage = image
        
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
