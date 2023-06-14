//
//  AuthPageViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 03.06.2023.
//

import UIKit

// Протокол для передачи данных от контроллера
protocol RegistrationPageViewControllerDelegate: AnyObject {
    func getRegistrationData(name: String,
                             surname: String,
                             phoneNumber: String,
                             password: String,
                             nickname: String)
    func toTheEntryPage(_ viewController: RegistrationPageViewController)
}

// Основной класс
class RegistrationPageViewController: UIViewController {
    
    deinit {
        print(#function)
    }
    
    
    weak var delegate: RegistrationPageViewControllerDelegate?
    
    // Константы для форматирования номера телефона
    internal let maxPhoneNumberCount = 11
    private let regex = try! NSRegularExpression(pattern: "[\\+\\s-\\(\\)]", options: .caseInsensitive)
    
    // Текстовые поля со сториборда
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
        
        phoneNumberTextField.delegate = self
        nicknameTextField.delegate = self
        repeatPasswordTextField.delegate = self
        surnameTextField.delegate = self
        
        phoneNumberTextField.keyboardType = .numberPad
    }
    
    
    
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    // Функция обработки нажатия кнопки "Получить код по СМС"
    @IBAction func getSMSCodeButton(_ sender: UIButton) {
        
        let name = nameTextField.text ?? ""
        let surname = surnameTextField.text ?? ""
        let phoneNumber = phoneNumberTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let repeatPassword = repeatPasswordTextField.text ?? ""
        let nickname = nicknameTextField.text ?? ""
        
        // Условия на Текстовые поля
        var message: String = ""
        
        if name.isEmpty {
            message += "- Имя не введено\n"
        }
        
        if surname.isEmpty {
            message += "- Фамилия не введена\n"
        }
        
        if phoneNumber == "" {
            message += "- Номер телефона не введен\n"
        }
        
        if password == "" {
            message += "- Пароль не введен\n"
        }
        
        if repeatPassword == "" {
            message += "- Пароль повторно не введен\n"
        }
        
        if nickname == "" {
            message += "- Никнейм не введен\n"
        }
        
        
        if !message.isEmpty {
            showAlert(title: "Не заполнены обязательный поля", message: message)
            return
        }
        
        
        
        
        // возврат на корневой UIViewVontroller
        navigationController?.popToRootViewController(animated: false)
        
        // передача данных подписанным UIViewControllers
        delegate?.getRegistrationData(name: name, surname: surname, phoneNumber: phoneNumber, password: password, nickname: nickname)
    
    }
    
    // Функция обработки нажания кнопки "Уже есть аккаунт"
    @IBAction func toTheEntryPageButton(_ sender: UIButton) {
//        navigationController?.popToRootViewController(animated: true)
        delegate?.toTheEntryPage(self)
    }
    
    // Функция для форматирования номера телефона
    func phoneNumerFormat(phoneNumber: String, shouldRemoveLastDigit: Bool) -> String {
        
        // Оставлять "+" при стирании номера
        guard !(shouldRemoveLastDigit && phoneNumber.count <= 2) else { return "+" }
        
        let range = NSString(string: phoneNumber).range(of: phoneNumber)
        var number = regex.stringByReplacingMatches(in: phoneNumber, options: [], range: range, withTemplate: "")
        
        if number.count > maxPhoneNumberCount {
            let maxIndex = number.index(number.startIndex, offsetBy: maxPhoneNumberCount)
            number = String(number[number.startIndex..<maxIndex])
        }
        
        if shouldRemoveLastDigit {
            let maxIndex = number.index(number.startIndex, offsetBy: number.count - 1)
            number = String(number[number.startIndex..<maxIndex])
        }
        
        let maxIndex = number.index(number.startIndex, offsetBy: number.count)
        let regRange = number.startIndex..<maxIndex
        
        let pattern = "(\\d)(\\d{3})(\\d{3})(\\d{2})(\\d+)".phoneMask()
        number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3-$4-$5", options: .regularExpression, range: regRange)
        
//        if number.count < 7 {
//            let pattern = "(\\d)(\\d{3})(\\d+)"
//            number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3", options: .regularExpression, range: regRange)
//        } else {
//            let pattern = "(\\d)(\\d{3})(\\d{3})(\\d{2})(\\d+)"
//            number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3-$4-$5", options: .regularExpression, range: regRange)
//        }

        return "+" + number
    }
}
