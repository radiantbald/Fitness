//
//  ScheduleViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 24.05.2023.
//

import UIKit

class PersonPageViewController: ViewController, UIGestureRecognizerDelegate {
    private lazy var imagePicker = UIImagePickerController()
    @IBOutlet weak var personPageAvatar: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        personPageAvatar.layer.cornerRadius = personPageAvatar.frame.size.width/2
        personPageAvatar.frame = CGRectMake(30, 100, 100, 100)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = true
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Личный кабинет"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Выйти", style: .plain, target: self, action: #selector(exit))
        print("Вы перешли в Личный кабинет")
        imagePicker.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarTapAction))
        tapGesture.delegate = self
        personPageAvatar.superview?.addGestureRecognizer(tapGesture)
        
    }
    
    @objc private func avatarTapAction() {
        let actionImage = UIAlertController(title: "Загрузка фоторгафии", message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Камера", style: .default) { _ in
            self.imagePicker.sourceType = .camera
            self.imagePicker.allowsEditing = true
            self.navigationController?.present(self.imagePicker, animated: true)
        }
        
        let photo = UIAlertAction(title: "Фотоальбом", style: .default) { _ in
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.allowsEditing = true
            self.navigationController?.present(self.imagePicker, animated: true)
        }
        
        let buffer = UIAlertAction(title: "Вставить из буффера", style: .default){ _ in
            if let image = UIPasteboard.general.image {
                self.saveImage(image)
            }
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        
        actionImage.addAction(camera)
        actionImage.addAction(photo)
        actionImage.addAction(buffer)
        actionImage.addAction(cancel)
        
        if let popover = actionImage.popoverPresentationController {
            popover.sourceView = self.view
            let frame = view.frame
            popover.sourceRect  =  CGRect(x: frame.midX, y: frame.maxY, width: 1.0, height: 1.0)
        }
        
        present(actionImage, animated: true)
    }
    
    @objc private func exit() {
        isAuth = false
        print("Вы вышли из аккаунта")
        navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    private func saveImage(_ image: UIImage) {
        personPageAvatar.image = image
        
        let data = image.jpegData(compressionQuality: 1)
        let name = "logo.jpeg"
        guard let file = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let path = file.appendingPathComponent(name)
        print(path.absoluteString)
        
        do {
            try? FileManager.default.removeItem(at: path)
            try data?.write(to: path)
        }
        
        catch let error {
            print(error.localizedDescription)
        }
    }
}



extension PersonPageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.saveImage(pickedImage)
            dismiss(animated: true)
        }
    }
}