//
//  RegistrationApproveViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 12.06.2023.
//

import UIKit

protocol SMSCodeApprovePageViewControllerDelegate: AnyObject {
    func authApprove()
}

class SMSCodeApprovePageViewController: GeneralViewController {
    
    var presenter: SMSCodeApprovePagePresenter!
    
    weak var delegate: SMSCodeApprovePageViewControllerDelegate?
    
    let inputCodeFromSMSTextLabel = UILabel()
    
    let sentPhoneNumberLabel = UILabel()
    var sentPhoneNumber: String = "+7 (000) 000-00-00"
    
    let stackViewOfDigitViews = UIStackView()
    var digitViews: [UIView] = []
    let stackViewOfDigitLabels = UIStackView()
    var digitLabels: [UILabel] = []
    
    let codeFromSMSTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        codeFromSMSTextField.delegate = self
        SMSCodeApprovePageDesign()
        hideKeyboardOnTap()
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
        
        //MARK: - добавление subview
        
        view.addSubview(inputCodeFromSMSTextLabel)
        view.addSubview(sentPhoneNumberLabel)
        view.addSubview(stackViewOfDigitViews)
        view.addSubview(stackViewOfDigitLabels)
        view.addSubview(codeFromSMSTextField)
        
        //MARK: - создание 6 полей красного цвета
        
        digitViews = Array(0...5).map { _ in
            return UIView()
        }
        
        for digitView in digitViews.enumerated() {
            stackViewOfDigitViews.addArrangedSubview(digitView.element)
            digitView.element.backgroundColor = .systemRed
            digitView.element.layer.cornerRadius = 12
            digitView.element.widthAnchor.constraint(equalTo: digitView.element.heightAnchor, multiplier: 0.7).isActive = true
            makeOpaq40(view: digitView.element)
        }
        
        //MARK: - создание 6 полей для цифр на полях красного цвета
        
        digitLabels = Array(0...5).map { _ in
            return UILabel()
        }
        
        for digitLabel in digitLabels.enumerated() {
            stackViewOfDigitLabels.addArrangedSubview(digitLabel.element)
            digitLabel.element.textColor = .white
            digitLabel.element.font = .boldSystemFont(ofSize: 30)
        }
        
        //MARK: - настройки subview
        
        [stackViewOfDigitViews, stackViewOfDigitLabels].forEach { subview in
            subview.axis = .horizontal
            subview.distribution = .equalSpacing
            subview.alignment = .fill
            subview.spacing = 10
        }
        
        //MARK: - Constraints
        
        [inputCodeFromSMSTextLabel, sentPhoneNumberLabel, stackViewOfDigitViews, stackViewOfDigitLabels, codeFromSMSTextField].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            
            inputCodeFromSMSTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            inputCodeFromSMSTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            inputCodeFromSMSTextLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            inputCodeFromSMSTextLabel.heightAnchor.constraint(equalToConstant: 25),
            
            sentPhoneNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            sentPhoneNumberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            sentPhoneNumberLabel.topAnchor.constraint(equalTo: inputCodeFromSMSTextLabel.bottomAnchor, constant: 15),
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
        
        //MARK: - Navigation items дизайн
        navigationItem.title = "Авторизация"
        navigationItem.backButtonTitle = "На главную"
        
        //MARK: - Введите код из СМС дизайн
        inputCodeFromSMSTextLabel.text = "Введите код из СМС"
        inputCodeFromSMSTextLabel.textAlignment = .center
        
        //MARK: - Номер телефона дизайн
        sentPhoneNumberLabel.text = sentPhoneNumber
        sentPhoneNumberLabel.textAlignment = .center
        
        //MARK: - TextField для кода из СМС дизайн
        codeFromSMSTextField.keyboardType = .numberPad
        codeFromSMSTextField.textAlignment = .left
        codeFromSMSTextField.textColor = .white
        codeFromSMSTextField.font = .monospacedDigitSystemFont(ofSize: 40, weight: .light)
        codeFromSMSTextField.defaultTextAttributes.updateValue(40.0, forKey: .kern)
        
    }
}

//MARK: - TextField делегаты

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
            if text.count != 6 { return }
            presenter.codeFromSMSRecieveAction(codeFromSMS: text)
        }
    }
}

//MARK: - Делегат презентера

extension SMSCodeApprovePageViewController: SMSCodeApprovePagePresenterDelegate {
    func successAuth() {
        isAuth = true
        navigationController?.popToRootViewController(animated: false)
        delegate?.authApprove()
    }
    
    func showAuthAlert(error: Error) {
        showAlert(title: "Ошибка", message: error.localizedDescription)
    }
    
    
}


//MARK: - Предпросмотр UI

//import SwiftUI
//struct SMSCodeApprovePageViewController_Provider: PreviewProvider {
//    static var previews: some View {
//        ContainerView().edgesIgnoringSafeArea(.all)
//    }
//
//    struct ContainerView: UIViewControllerRepresentable {
//
//        func makeUIViewController(context: Context) -> UIViewController {
//            return SMSCodeApprovePageViewController()
//        }
//
//        typealias UIViewControllerType = UIViewController
//
//        let viewController = SMSCodeApprovePageViewController()
//        func makeUIViewController(context: UIViewControllerRepresentableContext<SMSCodeApprovePageViewController_Provider.ContainerView>) -> SMSCodeApprovePageViewController {
//            return viewController
//        }
//
//        func updateUIViewController(_ uiViewController: SMSCodeApprovePageViewController_Provider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SMSCodeApprovePageViewController_Provider.ContainerView>) {
//
//        }
//    }
//}
