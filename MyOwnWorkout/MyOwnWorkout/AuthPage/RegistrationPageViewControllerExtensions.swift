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
        
        setupDelegate()
        setupTextFields()
    }
    
    //MARK: - Настройки Действий
    func setupActions() {
        
        print("Вы перешли на страницу регистрации")
        onRepeatPasswordSecurityToggle()
        
    }
}

//MARK: - Настройки текстовых полей
extension RegistrationPageViewController {
    
    func setupDelegate() {
        nameTextField.delegate = self
        surnameTextField.delegate = self
        phoneNumberTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
        nicknameTextField.delegate = self
    }
    
    func setupTextFields() {
        phoneNumberTextField.keyboardType = .numberPad
        
        passwordTextField.rightView = passwordTextFieldEyeButton
        passwordTextField.rightViewMode = .always
        passwordTextField.isSecureTextEntry = true
        
        repeatPasswordTextField.rightView = repeatPasswordTextFieldEyeButton
        repeatPasswordTextField.rightViewMode = .always
        repeatPasswordTextField.isSecureTextEntry = true
        repeatPasswordTextField.clearsOnBeginEditing = false
        
        //buttons
        let eye = UIImage(systemName: "eye")
        let eyeSlash = UIImage(systemName: "eye.slash")
        passwordTextFieldEyeButton.setImage(eyeSlash, for: .selected)
        passwordTextFieldEyeButton.setImage(eye, for: .normal)
        passwordTextFieldEyeButton.addTarget(self, action: #selector(passwordSecurityToggle(_:)), for: .touchUpInside)
    }
    
    
    //MARK: - Обработка кнопки скрытия/показа пароля
    @objc private func passwordSecurityToggle(_ sender: UIButton) {
        let status = !sender.isSelected
        sender.isSelected = status
        passwordTextField.isSecureTextEntry = !status
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
        
        switch textField {
        case nameTextField:
            textField.text = text.setCapitalLetters()
            textField.text = text.setNameAndSurnameSymbols(string: textField.text!)
            
        case surnameTextField:
            textField.text = text.setCapitalLetters()
            textField.text = text.setNameAndSurnameSymbols(string: textField.text!)
            
        case phoneNumberTextField:
            textField.text = text.phoneMaskRu()
            
        case passwordTextField:
            if passwordTextField.isSecureTextEntry {
                let text = textField.text
                print(text ?? "----")
                passwordTextField.text = text
            }
            
        default:break
            
        }
    }
}
