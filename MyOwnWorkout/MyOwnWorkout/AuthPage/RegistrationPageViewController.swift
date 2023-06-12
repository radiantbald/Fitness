//
//  AuthPageViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 03.06.2023.
//

import UIKit

protocol RegistrationPageViewControllerDelegate: AnyObject {
    func getRegistrationData(name: String,
                             surname: String,
                             phoneNumber: String,
                             password: String,
                             nickname: String)
    func toTheEntryPage()
}

class RegistrationPageViewController: UIViewController {
    
    weak var delegate: RegistrationPageViewControllerDelegate?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Регистрация"
        print("Вы перешли на страницу регистрации")
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func getSMSCodeButton(_ sender: UIButton) {
        
        let name = nameTextField.text ?? ""
        let surname = surnameTextField.text ?? ""
        let phoneNumber = phoneNumberTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let repeatPassword = repeatPasswordTextField.text ?? ""
        let nickname = nicknameTextField.text ?? ""
        
        //MARK: - Условия на TextField
        if name == "" {
            print("Имя не введено")
        } else {
            print(name)
        }
        if surname == "" {
            print("Фамилия не введена")
        } else {
            print(surname)
        }
        if phoneNumber == "" {
            print("Номер телефона не введен")
        } else {
            print(phoneNumber)
        }
        if password == "" {
            print("Пароль не введен")
        } else {
            print(password)
        }
        if repeatPassword == "" {
            print("Пароль повторно не введен")
        } else {
            print(repeatPassword)
        }
        if nickname == "" {
            print("Никнейм не введен")
        } else {
            print(nickname)
        }
        
        // возврат на корневой UIViewVontroller
        navigationController?.popToRootViewController(animated: false)
        
        // передача данных подписанным UIViewControllers
        delegate?.getRegistrationData(name: name, surname: surname, phoneNumber: phoneNumber, password: password, nickname: nickname)
    
    }
    
    @IBAction func toTheEntryPageButton(_ sender: UIButton) {
        delegate?.toTheEntryPage()
    }
    
}

//MARK: - Text Field
extension RegistrationPageViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {

    }
}
