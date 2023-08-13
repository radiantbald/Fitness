//
//  AuthPageViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 03.06.2023.
//

import UIKit

//MARK: - Протокол для передачи данных от контроллера
protocol RegistrationPageViewControllerDelegate: AnyObject {
    func getRegistrationData(name: String,
                             surname: String,
                             phoneNumber: String,
                             password: String,
                             nickname: String)
    func toTheEntryPage()
}

//MARK: -
class RegistrationPageViewController: GeneralViewController {
    
    private let presenter = RegistrationPagePresenter()
    
    weak var delegate: RegistrationPageViewControllerDelegate?

    //MARK: - Объекты полей ввода пароля
    var passwordTextFieldEyeButton = EyeButtonView()
    var repeatPasswordTextFieldEyeButton = EyeButtonView()
    
    //MARK: - Текстовые поля
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    
    //MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        setupView()
        setupActions()
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

//MARK: - Расширения

//MARK: - Корневые функции из расширений
extension RegistrationPageViewController {
    
    //MARK: - Настройки Отображения
    func setupView() {
        navigationItem.title = "Регистрация"
        setupDelegates()
        setupTextFields()
        
    }
    
    //MARK: - Настройки Действий
    func setupActions() {
        print("Вы перешли на страницу регистрации")
        
    }
}

//MARK: - Расширение настроек текстовых полей
extension RegistrationPageViewController {
    
    func setupDelegates() {
        nameTextField.delegate = self
        surnameTextField.delegate = self
        phoneNumberTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
        nicknameTextField.delegate = self
    }
    
    func setupTextFields() {
        phoneNumberTextField.keyboardType = .numberPad
        phoneNumberTextField.textContentType = .telephoneNumber
        
        passwordTextField.rightView = passwordTextFieldEyeButton
        passwordTextField.rightViewMode = .always
        passwordTextField.textContentType = .password
        passwordTextField.isSecureTextEntry = true
        
        repeatPasswordTextField.rightView = repeatPasswordTextFieldEyeButton
        repeatPasswordTextField.rightViewMode = .always
        repeatPasswordTextField.textContentType = .password
        repeatPasswordTextField.isSecureTextEntry = true
        
        //MARK: - Настройка отображения кнопок скрытия/показа пароля
        let eye = UIImage(systemName: "eye")
        let eyeSlash = UIImage(systemName: "eye.slash")
        
        passwordTextFieldEyeButton.setImage(eye, for: .normal)
        passwordTextFieldEyeButton.setImage(eyeSlash, for: .selected)
        passwordTextFieldEyeButton.addTarget(self, action: #selector(passwordSecurityToggle), for: .touchUpInside)
        
        repeatPasswordTextFieldEyeButton.setImage(eye, for: .normal)
        repeatPasswordTextFieldEyeButton.setImage(eyeSlash, for: .selected)
        repeatPasswordTextFieldEyeButton.addTarget(self, action: #selector(repeatPasswordSecurityToggle), for: .touchUpInside)
    }
    
    //MARK: - Настройка действия кнопок скрытия/показа пароля
    @objc private func passwordSecurityToggle(_ sender: UIButton) {
        let status = !sender.isSelected
        sender.isSelected = status
        passwordTextField.isSecureTextEntry = !status
    }
    @objc private func repeatPasswordSecurityToggle(_ sender: UIButton) {
        let status = !sender.isSelected
        sender.isSelected = status
        repeatPasswordTextField.isSecureTextEntry = !status
    }
}

//MARK: - Расширение настроек отображения содержания текстовых полей
extension RegistrationPageViewController: UITextFieldDelegate {

    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if textField == nameTextField {
            textField.text = text.setCapitalLetters()
            textField.text = text.setLettersHyphenAndApostropheSymbols(string: textField.text!)
        }
        if textField == surnameTextField {
            textField.text = text.setCapitalLetters()
            textField.text = text.setLettersHyphenAndApostropheSymbols(string: textField.text!)
        }
        
        if textField == phoneNumberTextField {
            textField.text = text.phoneMaskRu()
        }
        
        if textField == nicknameTextField {
            textField.text = text.setLettersNumbersAndUnderscoreSymbols(string: textField.text!)
        }
    }
}

//MARK: - Расширение настройки функционала кнопок
extension RegistrationPageViewController {
    
    //MARK: - Функция обработки нажатия кнопки "Получить код по СМС"
    @IBAction func getSMSCodeButton(_ sender: UIButton) {
        
        let name = nameTextField.text ?? ""
        let surname = surnameTextField.text ?? ""
        let phoneNumber = phoneNumberTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let repeatPassword = repeatPasswordTextField.text ?? ""
        let nickname = nicknameTextField.text ?? ""
        
        //MARK: - Условия на Текстовые поля
        
        var message: String = ""
        
        if name.isEmpty {
            message += " - Имя не введено\n"
        }
        if surname.isEmpty {
            message += " - Фамилия не введена\n"
        }
        if phoneNumber.isEmpty {
            message += " - Номер телефона не введен\n"
        }
        if password.isEmpty {
            message += " - Пароль не введен\n"
        }
        if repeatPassword.isEmpty {
            message += " - Пароль повторно не введен\n"
        }
        if nickname.isEmpty {
            message += " - Никнейм не введен\n"
        }
        if !message.isEmpty {
            showAlert(title: "Не заполнены обязательные поля\n", message: message)
            return
        }
        
        let userDataArray = [name, surname, phoneNumber, password, nickname]
        let userDataString = userDataArray.joined(separator: "\n")
        let userData = userDataString.data(using: .utf8)
        
        let userDataName = "UserData.txt"
        guard let file = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let path = file.appendingPathComponent(userDataName)
        print(path.absoluteString)
        
        do {
//            try FileManager.default.removeItem(at: path)
            try userData?.write(to: path)
        }
        catch let error {
            print(error.localizedDescription)
        }
        
        // возврат на корневой UIViewVontroller
        navigationController?.popToRootViewController(animated: false)
        
        // передача данных подписанным UIViewControllers
        delegate?.getRegistrationData(name: name, surname: surname, phoneNumber: phoneNumber, password: password, nickname: nickname)
    }
    
    //MARK: - Функция обработки нажания кнопки "Уже есть аккаунт"
    @IBAction func toTheEntryPageButton(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: false)
        delegate?.toTheEntryPage()
    }
}

extension RegistrationPageViewController: RegistrationPagePresenterDelegate {

}
