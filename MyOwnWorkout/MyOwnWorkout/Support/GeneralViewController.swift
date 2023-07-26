//
//  GeneralViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 23.07.2023.
//

import UIKit

class GeneralViewController: UIViewController {
    private let avatarName = "UserAvatar"
    
    //MARK: - get/set статуса авторизациии
    var avatarImage: UIImage? {
        get {
            if let data = FileManager.getObject(name: avatarName, of: "jpeg"),
               let image = UIImage(data: data) {
                return image
            }
            return nil
        }
        
        set {
            guard let imageData = newValue?.jpegData(compressionQuality: 1) else { return }
            let result = FileManager.saveObject(data: imageData, name: avatarName, of: "jpeg")
        }
    }
    
    var isAuth: Bool {
        get {
            return DataBase.isAuth
        }
        set {
            DataBase.isAuth = newValue
        }
    }
    
    //MARK: - Настройка кнопки - аватарки
    
    @IBAction func avatarButton(_ sender: UIButton) {
        
        if isAuth {
            print("Авторизация пройдена")
            guard let viewController = PersonPageViewController.storyboardInit else { return }
            viewController.modalPresentationStyle = .overFullScreen
            navigationController?.pushViewController(viewController, animated: true)
        } else {
            print("Авторизация не пройдена")
            guard let viewController = EntryPageViewController.storyboardInit else { return }
            viewController.modalPresentationStyle = .overFullScreen
            viewController.delegate = self
            navigationController?.pushViewController(viewController, animated: true)
            
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
        navigationItem.backButtonTitle = "Назад"
    }
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
        print(nickname, password)
        save(nickname: nickname, password: password)
        
        
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
    private func save(nickname: String, password: String) {
        
        let auth = AuthModel(login: nickname, password: password)
        guard let data = try? JSONEncoder().encode(auth) else { return }
        Keychain.standart.set(data, forKey: "keyAuth")
    }
}
