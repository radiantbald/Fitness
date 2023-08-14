//
//  RegistrationApproveViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 12.06.2023.
//

import UIKit

protocol SMSCodeApprovePageViewControllerDelegate: AnyObject {
    func getCodeFromSMS(codeFromSMS: String)
}

class SMSCodeApprovePageViewController: GeneralViewController {
    
    private let presenter = SMSCodeApprovePagePresenter()
    
    weak var delegate: SMSCodeApprovePageViewControllerDelegate?
    
    let delegatedPhoneNumber = "123"

    let inputLabel: UILabel = {
        let inputLabel = UILabel()
        inputLabel.translatesAutoresizingMaskIntoConstraints = false
        return inputLabel
    }()
    
    let sentPhoneNumberLabel: UILabel = {
        let sentNumberLabel = UILabel()
        sentNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        return sentNumberLabel
    }()
    
    let SMSTextFieldBackgroundView: UIView = {
        let SMSTextFieldBackgroundView = UIView()
        SMSTextFieldBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        return SMSTextFieldBackgroundView
    }()

    let SMSTextFieldMask1: UIView = {
        let SMSTextFieldMask1 = UIView()
        SMSTextFieldMask1.translatesAutoresizingMaskIntoConstraints = false
        return SMSTextFieldMask1
    }()
    
    let SMSTextFieldMask2: UIView = {
        let SMSTextFieldMask2 = UIView()
        SMSTextFieldMask2.translatesAutoresizingMaskIntoConstraints = false
        return SMSTextFieldMask2
    }()
    
    let SMSTextFieldMask3: UIView = {
        let SMSTextFieldMask3 = UIView()
        SMSTextFieldMask3.translatesAutoresizingMaskIntoConstraints = false
        return SMSTextFieldMask3
    }()
    
    let SMSTextFieldMask4: UIView = {
        let SMSTextFieldMask4 = UIView()
        SMSTextFieldMask4.translatesAutoresizingMaskIntoConstraints = false
        return SMSTextFieldMask4
    }()
    
    let SMSTextFieldMask5: UIView = {
        let SMSTextFieldMask5 = UIView()
        SMSTextFieldMask5.translatesAutoresizingMaskIntoConstraints = false
        return SMSTextFieldMask5
    }()
    
    let SMSTextFieldMask6: UIView = {
        let SMSTextFieldMask6 = UIView()
        SMSTextFieldMask6.translatesAutoresizingMaskIntoConstraints = false
        return SMSTextFieldMask6
    }()
    
    let codeFromSMSTextField: UITextField = {
        let codeFromSMSTextField = UITextField()
        codeFromSMSTextField.translatesAutoresizingMaskIntoConstraints = false
        return codeFromSMSTextField
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        SMSCodeApprovePageDesign()
        codeFromSMSTextField.delegate = self
        codeFromSMSTextField.textAlignment = .center
        
        let tapToHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapToHideKeyboard.delegate = self
        tapToHideKeyboard.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapToHideKeyboard)
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

//MARK: - Extensions

extension SMSCodeApprovePageViewController {
    
    func SMSCodeApprovePageDesign() {
        navigationItem.title = "Авторизация"
        navigationItem.backButtonTitle = "На главную"
        
        view.addSubview(inputLabel)
        view.addSubview(sentPhoneNumberLabel)
        view.addSubview(SMSTextFieldBackgroundView)
        view.addSubview(SMSTextFieldMask1)
        view.addSubview(SMSTextFieldMask2)
        view.addSubview(SMSTextFieldMask3)
        view.addSubview(SMSTextFieldMask4)
        view.addSubview(SMSTextFieldMask5)
        view.addSubview(SMSTextFieldMask6)
        view.addSubview(codeFromSMSTextField)
        
        inputLabel.text = "Введите код из СМС"
        inputLabel.textAlignment = .center
        
        sentPhoneNumberLabel.text = "\(delegatedPhoneNumber)"
        sentPhoneNumberLabel.textAlignment = .center
        
        SMSTextFieldMask1.layer.cornerRadius = 10
        SMSTextFieldMask2.layer.cornerRadius = 10
        SMSTextFieldMask3.layer.cornerRadius = 10
        SMSTextFieldMask4.layer.cornerRadius = 10
        SMSTextFieldMask5.layer.cornerRadius = 10
        SMSTextFieldMask6.layer.cornerRadius = 10

        SMSTextFieldMask1.backgroundColor = .systemRed
        SMSTextFieldMask2.backgroundColor = .systemRed
        SMSTextFieldMask3.backgroundColor = .systemRed
        SMSTextFieldMask4.backgroundColor = .systemRed
        SMSTextFieldMask5.backgroundColor = .systemRed
        SMSTextFieldMask6.backgroundColor = .systemRed
        
        SMSTextFieldMask1.layer.opacity = 0.4
        SMSTextFieldMask2.layer.opacity = 0.4
        SMSTextFieldMask3.layer.opacity = 0.4
        SMSTextFieldMask4.layer.opacity = 0.4
        SMSTextFieldMask5.layer.opacity = 0.4
        SMSTextFieldMask6.layer.opacity = 0.4
        
        codeFromSMSTextField.keyboardType = .numberPad
        codeFromSMSTextField.textColor = .white
        codeFromSMSTextField.font = .monospacedDigitSystemFont(ofSize: 25, weight: .light)
        codeFromSMSTextField.defaultTextAttributes.updateValue(35.0, forKey: .kern)
        
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            
            inputLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
            inputLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            inputLabel.heightAnchor.constraint(equalToConstant: 25),
            inputLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 15),
            
            sentPhoneNumberLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
            sentPhoneNumberLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            sentPhoneNumberLabel.heightAnchor.constraint(equalToConstant: 25),
            sentPhoneNumberLabel.topAnchor.constraint(equalTo: inputLabel.bottomAnchor, constant: 15),

            SMSTextFieldBackgroundView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
            SMSTextFieldBackgroundView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            SMSTextFieldBackgroundView.heightAnchor.constraint(equalToConstant: 50),
            SMSTextFieldBackgroundView.topAnchor.constraint(equalTo: sentPhoneNumberLabel.bottomAnchor, constant: 20),
            
            SMSTextFieldMask1.heightAnchor.constraint(equalToConstant: 50),
            SMSTextFieldMask1.widthAnchor.constraint(equalToConstant: 25),
            SMSTextFieldMask1.topAnchor.constraint(equalTo: SMSTextFieldBackgroundView.topAnchor),
            SMSTextFieldMask1.leadingAnchor.constraint(equalTo: codeFromSMSTextField.leadingAnchor, constant: -5),

            SMSTextFieldMask2.heightAnchor.constraint(equalToConstant: 50),
            SMSTextFieldMask2.widthAnchor.constraint(equalToConstant: 25),
            SMSTextFieldMask2.topAnchor.constraint(equalTo: SMSTextFieldBackgroundView.topAnchor),
            SMSTextFieldMask2.leadingAnchor.constraint(equalTo: SMSTextFieldMask1.trailingAnchor, constant: 25),

            SMSTextFieldMask3.heightAnchor.constraint(equalToConstant: 50),
            SMSTextFieldMask3.widthAnchor.constraint(equalToConstant: 25),
            SMSTextFieldMask3.topAnchor.constraint(equalTo: SMSTextFieldBackgroundView.topAnchor),
            SMSTextFieldMask3.leadingAnchor.constraint(equalTo: SMSTextFieldMask2.trailingAnchor, constant: 25),

            SMSTextFieldMask4.heightAnchor.constraint(equalToConstant: 50),
            SMSTextFieldMask4.widthAnchor.constraint(equalToConstant: 25),
            SMSTextFieldMask4.topAnchor.constraint(equalTo: SMSTextFieldBackgroundView.topAnchor),
            SMSTextFieldMask4.leadingAnchor.constraint(equalTo: SMSTextFieldMask3.trailingAnchor, constant: 25),

            SMSTextFieldMask5.heightAnchor.constraint(equalToConstant: 50),
            SMSTextFieldMask5.widthAnchor.constraint(equalToConstant: 25),
            SMSTextFieldMask5.topAnchor.constraint(equalTo: SMSTextFieldBackgroundView.topAnchor),
            SMSTextFieldMask5.leadingAnchor.constraint(equalTo: SMSTextFieldMask4.trailingAnchor, constant: 25),

            SMSTextFieldMask6.heightAnchor.constraint(equalToConstant: 50),
            SMSTextFieldMask6.widthAnchor.constraint(equalToConstant: 25),
            SMSTextFieldMask6.topAnchor.constraint(equalTo: SMSTextFieldBackgroundView.topAnchor),
            SMSTextFieldMask6.leadingAnchor.constraint(equalTo: SMSTextFieldMask5.trailingAnchor, constant: 25),
            
            codeFromSMSTextField.heightAnchor.constraint(equalToConstant: 50),
            codeFromSMSTextField.topAnchor.constraint(equalTo: SMSTextFieldBackgroundView.topAnchor),
            codeFromSMSTextField.leadingAnchor.constraint(equalTo: SMSTextFieldBackgroundView.centerXAnchor, constant: -132),
            codeFromSMSTextField.trailingAnchor.constraint(equalTo: SMSTextFieldBackgroundView.centerXAnchor, constant: 228)
        ])
    }
}

extension SMSCodeApprovePageViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if textField == codeFromSMSTextField {
            textField.text = text.codeFromSMSMask()
            
            if text.count > 5 {
                SMSTextFieldMask6.layer.opacity = 1
            }
            if text.count > 4 {
                SMSTextFieldMask5.layer.opacity = 1
            }
            if text.count > 3 {
                SMSTextFieldMask4.layer.opacity = 1
            }
            if text.count > 2 {
                SMSTextFieldMask3.layer.opacity = 1
            }
            if text.count > 1 {
                SMSTextFieldMask2.layer.opacity = 1
            }
            if text.count > 0 {
                SMSTextFieldMask1.layer.opacity = 1
            }
            if text.count < 6 {
                SMSTextFieldMask6.layer.opacity = 0.4
            }
            if text.count < 5 {
                SMSTextFieldMask5.layer.opacity = 0.4
            }
            if text.count < 4 {
                SMSTextFieldMask4.layer.opacity = 0.4
            }
            if text.count < 3 {
                SMSTextFieldMask3.layer.opacity = 0.4
            }
            if text.count < 2 {
                SMSTextFieldMask2.layer.opacity = 0.4
            }
            if text.count < 1 {
                SMSTextFieldMask1.layer.opacity = 0.4
            }
            if text == "000000" {
                isAuth = true
                navigationController?.popToRootViewController(animated: false)
                delegate?.getCodeFromSMS(codeFromSMS: text)
                
            } else if text.count == "000000".count && text != "000000" {
                textField.text = ""
                showAlert(title: "\(text) - неверный код", message: "Попробуйте еще раз")
            }
        }
    }
}

extension SMSCodeApprovePageViewController: SMSCodeApprovePagePresenterDelegate {
}
