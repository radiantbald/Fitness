//
//  GeneralViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 23.07.2023.
//

import UIKit

class GeneralViewController: UIViewController {
    
    var doNotUseAuth: Bool {
        return true
    }
    //MARK: - get/set статуса авторизациии
    
    var isAuth: Bool {
        get {
            return UserDefaultsDataBase.isAuth
        }
        set {
            UserDefaultsDataBase.isAuth = newValue
        }
    }
    
    //MARK: - Установка Аватарки
    var avatarImage: UIImage? {
        get {
            if let data = FileManager.getObject(name: FilesNamesKeys.UserAvatar.rawValue, type: FilesTypesKeys.jpeg.rawValue),
               let image = UIImage(data: data),
               isAuth {
                return image
            }
            return UIImage(named: "CabinetLogo")
        }
        set {
            guard let imageData = newValue?.jpegData(compressionQuality: 1) else { return }
            let result = FileManager.setObject(data: imageData, name: FilesNamesKeys.UserAvatar.rawValue, type: FilesTypesKeys.jpeg.rawValue)
            print("Картинка ", result ? "Сохранилась" : "Не сохранилась")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
    
}

//MARK: - Расширения

//MARK: - Общие настройки

extension GeneralViewController {
    
    //MARK: - Настройки NavigationBar
    
    func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .black
    }
    
    //MARK: - Закругление изображения
    
    func setupAvatarBounds(_ avatar: UIImageView) {
        avatar.contentMode = .scaleAspectFill
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = avatar.frame.size.height/2
    }
}

//MARK: - Настройки жестов

extension GeneralViewController: UIGestureRecognizerDelegate {
    
    //MARK: - Прятать клавиатуру при тапе на экран
    
    func hideKeyboardOnTap() {
        let tapToHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTapSelector))
        tapToHideKeyboard.delegate = self
        tapToHideKeyboard.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapToHideKeyboard)
    }
    @objc func hideKeyboardOnTapSelector() {
        view.endEditing(true)
    }
}

//MARK: - Настройки непрозрачности

extension GeneralViewController {
    func makeOpaq40(view: UIView) {
        view.layer.opacity = 0.4
    }
    func makeOpaq100(view: UIView) {
        view.layer.opacity = 1
    }
}
