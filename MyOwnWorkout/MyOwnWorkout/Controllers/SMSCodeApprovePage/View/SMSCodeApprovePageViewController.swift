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
    
    let inputTextLabel = UILabel()
    
    let sentPhoneNumberLabel = UILabel()
    
    let stackViewOfDigitViews = UIStackView()
    var digitViews: [UIView] = []
    let stackViewOfDigitLabels = UIStackView()
    var digitLabels: [UILabel] = []
    
    let codeFromSMSTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        SMSCodeApprovePageDesign()
        codeFromSMSTextField.delegate = self
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
    
    func makeOpaq40(view: UIView) {
        view.layer.opacity = 0.4
    }
    func makeOpaq100(view: UIView) {
        view.layer.opacity = 1
    }
    
    
    func SMSCodeApprovePageDesign() {
        
        //MARK: - создание 6 полей красного цвета
        
        
        digitViews = Array(0...5).map { _ in
            return UIView()
        }
        digitLabels = Array(0...5).map { _ in
            return UILabel()
        }
        
        
        for digitView in digitViews.enumerated() {
            stackViewOfDigitViews.addArrangedSubview(digitView.element)
            digitView.element.backgroundColor = .systemRed
            digitView.element.layer.cornerRadius = 12
            digitView.element.widthAnchor.constraint(equalTo: digitView.element.heightAnchor, multiplier: 0.7).isActive = true
            makeOpaq40(view: digitView.element)
            
        }
        
        for digitLabel in digitLabels.enumerated() {
            stackViewOfDigitLabels.addArrangedSubview(digitLabel.element)
            digitLabel.element.textColor = .white
            digitLabel.element.font = .boldSystemFont(ofSize: 30)
        }
        
        
        view.addSubview(inputTextLabel)
        view.addSubview(sentPhoneNumberLabel)
        view.addSubview(stackViewOfDigitViews)
        view.addSubview(stackViewOfDigitLabels)
        view.addSubview(codeFromSMSTextField)
        
        [stackViewOfDigitViews, stackViewOfDigitLabels].forEach { subview in
            subview.axis = .horizontal
            subview.distribution = .equalSpacing
            subview.alignment = .fill
            subview.spacing = 10
        }
        
        [inputTextLabel, sentPhoneNumberLabel, stackViewOfDigitViews, stackViewOfDigitLabels, codeFromSMSTextField].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
 
        NSLayoutConstraint.activate([
                
            inputTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            inputTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            inputTextLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            inputTextLabel.heightAnchor.constraint(equalToConstant: 25),
            
            sentPhoneNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            sentPhoneNumberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            sentPhoneNumberLabel.topAnchor.constraint(equalTo: inputTextLabel.bottomAnchor, constant: 15),
            sentPhoneNumberLabel.heightAnchor.constraint(equalToConstant: 25),
            
            stackViewOfDigitViews.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            stackViewOfDigitViews.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            stackViewOfDigitViews.topAnchor.constraint(equalTo: sentPhoneNumberLabel.bottomAnchor, constant: 30),
            stackViewOfDigitViews.heightAnchor.constraint(equalToConstant: 60),
            
            stackViewOfDigitLabels.centerXAnchor.constraint(equalTo: stackViewOfDigitViews.centerXAnchor),
            stackViewOfDigitLabels.leadingAnchor.constraint(equalTo: stackViewOfDigitViews.leadingAnchor, constant: 12),
//            stackViewOfDigitLabels.trailingAnchor.constraint(equalTo: stackViewOfDigitViews.trailingAnchor, constant:  -16),
            stackViewOfDigitLabels.topAnchor.constraint(equalTo: sentPhoneNumberLabel.bottomAnchor, constant: 30),
            stackViewOfDigitLabels.heightAnchor.constraint(equalToConstant: 60),
            
            codeFromSMSTextField.leadingAnchor.constraint(equalTo: stackViewOfDigitViews.leadingAnchor, constant: 0),
            codeFromSMSTextField.trailingAnchor.constraint(equalTo: stackViewOfDigitViews.trailingAnchor, constant: 0),
            codeFromSMSTextField.topAnchor.constraint(equalTo: sentPhoneNumberLabel.bottomAnchor, constant: 30),
            codeFromSMSTextField.heightAnchor.constraint(equalToConstant: 60)
            
        ])
        
        navigationItem.title = "Авторизация"
        navigationItem.backButtonTitle = "На главную"
        
        inputTextLabel.text = "Введите код из СМС"
        inputTextLabel.textAlignment = .center
        
        
        
        
        guard let data = Keychain.standart.getData(KeychainKeys.PhoneNumberKeys.rawValue) else { return }
        guard let value = try?JSONDecoder().decode(PhoneNumberModel.self, from: data) else { return }
        sentPhoneNumberLabel.text = value.number
        sentPhoneNumberLabel.textAlignment = .center
        
        codeFromSMSTextField.keyboardType = .numberPad
        codeFromSMSTextField.textAlignment = .left
        codeFromSMSTextField.textColor = .white
        codeFromSMSTextField.font = .monospacedDigitSystemFont(ofSize: 40, weight: .light)
        codeFromSMSTextField.defaultTextAttributes.updateValue(40.0, forKey: .kern)
        
    }
}

extension SMSCodeApprovePageViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if textField == codeFromSMSTextField {
            textField.text = text.codeFromSMSMask()
            
            //MARK: - форматирование непрозрачности элементов за текстом при вводе
            
            for digitView in digitViews.enumerated() {
                if digitView.offset < text.count {
                    makeOpaq100(view: digitView.element)
                }
                else {
                    makeOpaq40(view: digitView.element)
                }
            }
  
            //MARK: - Валидация кода из СМС
            
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

import SwiftUI
struct SMSCodeApprovePageViewController_Provider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        func makeUIViewController(context: Context) -> UIViewController {
            return SMSCodeApprovePageViewController()
        }
        
        typealias UIViewControllerType = UIViewController
        
        let viewController = SMSCodeApprovePageViewController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<SMSCodeApprovePageViewController_Provider.ContainerView>) -> SMSCodeApprovePageViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: SMSCodeApprovePageViewController_Provider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SMSCodeApprovePageViewController_Provider.ContainerView>) {
            
        }
    }
}
