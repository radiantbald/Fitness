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
    
    
}

//MARK: - RegistrationPageViewControllerDelegate

extension GeneralViewController: RegistrationPageViewControllerDelegate {
    func getRegistrationData(name: String, surname: String, phoneNumber: String, password: String, nickname: String) {
        print(name, surname, phoneNumber, password, nickname)
        guard let viewController = SMSCodeApprovePageViewController.storyboardInit else { return }
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: false)
    }
    func toTheEntryPage() {
        guard let viewController = EntryPageViewController.storyboardInit else { return }
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: false)
    }
}

//MARK: - EntryPageViewControllerDelegate

extension GeneralViewController: EntryPageViewControllerDelegate {
    func getEntryData(nickname: String, password: String) {
        setSensitiveData(nickname: nickname, password: password)
        
        guard let viewController = SMSCodeApprovePageViewController.storyboardInit else { return }
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: false)
    }
    func toTheRegistrationPage() {
        guard let viewController = RegistrationPageViewController.storyboardInit else { return }
        viewController.delegate = self
        
        navigationController?.pushViewController(viewController, animated: false)
    }
}

//MARK: - SMSCodeApprovePageViewControllerDelegate

extension GeneralViewController: SMSCodeApprovePageViewControllerDelegate {
    func getCodeFromSMS(codeFromSMS: String) {
        print(codeFromSMS)
        guard let viewController = PersonPageViewController.storyboardInit else { return }
        navigationController?.pushViewController(viewController, animated: false)
    }
}

extension GeneralViewController {
    private func setSensitiveData(nickname: String, password: String) {
        
        let auth = AuthModel(login: nickname, password: password)
        guard let data = try? JSONEncoder().encode(auth) else { return }
        Keychain.standart.set(data, forKey: KeychainKeys.AuthKeys.rawValue)
    }
}
