//
//  GeneralViewController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 23.07.2023.
//

import UIKit

class GeneralViewController: UIViewController {
    
    //MARK: - get/set статуса авторизациии
    
    var isAuth: Bool {
        get {
            return DataBase.isAuth
        }
        set {
            DataBase.isAuth = newValue
        }
    }
    
    var isNewAvatarImage: Bool {
        get {
            return DataBase.isNewAvatarImage
        }
        set {
            DataBase.isNewAvatarImage = newValue
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
