//
//  GeneralViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 23.07.2023.
//

import UIKit

class GeneralViewController: UIViewController {

    //MARK: - Списки ключей
    
    enum KeychainKeys: String {
        case AuthKeys = "AuthKeys"
        case VerificationID = "VerificationID"
    }
    
    enum FilesNames: String {
        case UserAvatar = "UserAvatar"
    }
    
    enum FilesTypes: String {
        case jpeg = "jpeg"
    }
    
    //MARK: - get/set статуса авторизациии
    
    var isAuth: Bool {
        get {
            return DataBase.isAuth
        }
        set {
            DataBase.isAuth = newValue
        }
    }
    
    //MARK: - Установка Аватарки
    var avatarImage: UIImage? {
        get {
            if let data = FileManager.getObject(name: FilesNames.UserAvatar.rawValue, type: FilesTypes.jpeg.rawValue),
               let image = UIImage(data: data),
               isAuth {
                return image
            }
            return UIImage(named: "AppIcon")
        }
        set {
            guard let imageData = newValue?.jpegData(compressionQuality: 1) else { return }
            let result = FileManager.setObject(data: imageData, name: FilesNames.UserAvatar.rawValue, type: FilesTypes.jpeg.rawValue)
            print("Картинка ", result ? "Сохранилась" : "Не сохранилась")
        }
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
    
    func setupAvatarBounds(avatar: UIImageView) {
        avatar.contentMode = .scaleAspectFill
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = avatar.frame.size.width/2
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

extension GeneralViewController {
    private func setSensitiveData(nickname: String, password: String) {
        let auth = AuthModel(login: nickname, password: password)
        guard let data = try? JSONEncoder().encode(auth) else { return }
        Keychain.standart.set(data, forKey: KeychainKeys.AuthKeys.rawValue)
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
