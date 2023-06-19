//
//  RegistrationPageViewControllerExtentions.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 16.06.2023.
//

import UIKit


extension RegistrationPageViewController {
    
    //MARK: - Настройки Отображения
    func setupView() {

        navigationItem.title = "Регистрация"
        
        setupNameTextField()
        setupSurnameTextField()
        setupPhoneNumberTextField()
        setupPasswordTextField()
        setupRepeatPasswordTextField()
        setupNicknameTextField()
        
    }
    
    //MARK: - Настройки Действий
    func setupActions() {
        
        print("Вы перешли на страницу регистрации")
        
        onPasswordSecurityToggle()
        onRepeatPasswordSecurityToggle()
        
    }
}

//MARK: - Настройки текстовых полей
extension RegistrationPageViewController {
    
    func setupNameTextField() {
        nameTextField.delegate = self
    }
    
    func setupSurnameTextField() {
        surnameTextField.delegate = self
    }
    
    func setupPhoneNumberTextField() {
        phoneNumberTextField.delegate = self
        phoneNumberTextField.keyboardType = .numberPad
    }
    
    func setupPasswordTextField() {
        passwordTextField.delegate = self
        passwordTextField.rightView = passwordTextFieldEyeButton
        passwordTextField.rightViewMode = .always
        passwordTextField.isSecureTextEntry = true
    }
    
    func setupRepeatPasswordTextField() {
        repeatPasswordTextField.delegate = self
        repeatPasswordTextField.rightView = repeatPasswordTextFieldEyeButton
        repeatPasswordTextField.rightViewMode = .always
        repeatPasswordTextField.isSecureTextEntry = true
        repeatPasswordTextField.clearsOnBeginEditing = false
    }
    
    func setupNicknameTextField() {
        nicknameTextField.delegate = self
    }
    
    //MARK: - Обработка кнопки скрытия/показа пароля
    @objc
    func passwordSecurityToggle() {
        let imageName = passwordIsPrivate ? "eye.slash" : "eye"
        
        passwordTextField.isSecureTextEntry.toggle()
        passwordTextFieldEyeButton.setImage(UIImage(systemName: imageName), for: .normal)
        passwordIsPrivate.toggle()
    }
    
    func onPasswordSecurityToggle() {
        passwordTextFieldEyeButton.addTarget(self, action: #selector(passwordSecurityToggle), for: .touchUpInside)
    }
    
    @objc
    func repeatPasswordSecurityToggle() {
        let imageName = repeatPasswordIsPrivate ? "eye.slash" : "eye"
        
        repeatPasswordTextField.isSecureTextEntry.toggle()
        repeatPasswordTextFieldEyeButton.setImage(UIImage(systemName: imageName), for: .normal)
        repeatPasswordIsPrivate.toggle()
    }
    
    func onRepeatPasswordSecurityToggle() {
        repeatPasswordTextFieldEyeButton.addTarget(self, action: #selector(repeatPasswordSecurityToggle), for: .touchUpInside)
    }
}

//MARK: - Настройки отображения текста в текстовых полях

extension RegistrationPageViewController: UITextFieldDelegate {

    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if textField == nameTextField {
            textField.text = text.setCapitalLetters()
            textField.text = text.setNameAndSurnameSymbols(string: textField.text!)
        }
        if textField == surnameTextField {
            textField.text = text.setCapitalLetters()
            textField.text = text.setNameAndSurnameSymbols(string: textField.text!)
        }
        
        if textField == phoneNumberTextField {
            textField.text = text.phoneMaskRu()
        }
    }
}
