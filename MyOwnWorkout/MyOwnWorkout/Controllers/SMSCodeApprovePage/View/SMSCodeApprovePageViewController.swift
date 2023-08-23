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
    
    var digitViews: [UIView] = []
    var digitLabels: [UILabel] = []
    
    lazy var codeFromSMSTextField: UITextField = {
        let textField = UITextField()
        textField.alpha = 0
        textField.keyboardType = .numberPad
        return textField
    }()
    
//    let codeFromSMSTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        SMSCodeApprovePageDesign()
        codeFromSMSTextField.delegate = self
        
//        guard let data = Keychain.standart.getData(KeychainKeys.PhoneNumberKeys.rawValue) else { return }
//        guard let value = try?JSONDecoder().decode(PhoneNumberModel.self, from: data) else { return }
//        sentPhoneNumberLabel.text = value.number
        
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
        
        
        
        let inputTextLabel = UILabel()
        
        let sentPhoneNumberLabel = UILabel()
        
        let stackViewOfDigitViews = UIStackView()
    
        digitViews = Array(0...5).map { _ in
            return UIView()
        }
        
        digitLabels = digitViews.map { view in
            let label = UILabel()
            view.addSubview(label)
            return label
        }
        
//        for _ in 0...5 {
//            digitViews.append(UIView())
//        }
        
//        digitViews[0].layer.opacity = 0.4
        
        
        [inputTextLabel, sentPhoneNumberLabel, stackViewOfDigitViews, codeFromSMSTextField].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        
        digitViews.forEach { digitView in
            
            stackViewOfDigitViews.addArrangedSubview(digitView)
            digitView.backgroundColor = .systemRed
            digitView.layer.cornerRadius = 12
            digitView.widthAnchor.constraint(equalTo: digitView.heightAnchor, multiplier: 0.7).isActive = true
        }
        
        view.addSubview(inputTextLabel)
        view.addSubview(sentPhoneNumberLabel)
        view.addSubview(stackViewOfDigitViews)
        view.addSubview(codeFromSMSTextField)
        
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
            
        ])
        
        navigationItem.title = "Авторизация"
        navigationItem.backButtonTitle = "На главную"
        
        inputTextLabel.text = "Введите код из СМС"
        inputTextLabel.textAlignment = .center
        
        stackViewOfDigitViews.axis = .horizontal
        stackViewOfDigitViews.distribution = .equalSpacing
        stackViewOfDigitViews.alignment = .fill
        stackViewOfDigitViews.spacing = 10
        
        
        guard let data = Keychain.standart.getData(KeychainKeys.PhoneNumberKeys.rawValue) else { return }
        guard let value = try?JSONDecoder().decode(PhoneNumberModel.self, from: data) else { return }
        sentPhoneNumberLabel.text = value.number
        sentPhoneNumberLabel.textAlignment = .center
        
        codeFromSMSTextField.keyboardType = .numberPad
        codeFromSMSTextField.textAlignment = .left
        codeFromSMSTextField.textColor = .white
        codeFromSMSTextField.font = .monospacedDigitSystemFont(ofSize: 42, weight: .light)
        codeFromSMSTextField.defaultTextAttributes.updateValue(38.0, forKey: .kern)
        
    }
}

extension SMSCodeApprovePageViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if textField == codeFromSMSTextField {
            textField.text = text.codeFromSMSMask()

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
