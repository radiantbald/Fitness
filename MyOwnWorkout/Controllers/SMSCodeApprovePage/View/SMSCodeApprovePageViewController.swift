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
    var sentPhoneNumber: String = "+7 (111) 111-11-11"
    
    private let verifyView = VerifyView()

    override func viewDidLoad() {
        super.viewDidLoad()
        SMSCodeApprovePageDesign()
        hideKeyboardOnTap()
        verifyView.verifyProtocol = self
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
        
        //MARK: - добавление subviews
        
        view.addSubviews(inputCodeFromSMSTextLabel, sentPhoneNumberLabel, verifyView)
        
        //MARK: - Constraints
        
        NSLayoutConstraint.activate([
            
            inputCodeFromSMSTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            inputCodeFromSMSTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            inputCodeFromSMSTextLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            inputCodeFromSMSTextLabel.heightAnchor.constraint(equalToConstant: 25),
            
            sentPhoneNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            sentPhoneNumberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            sentPhoneNumberLabel.topAnchor.constraint(equalTo: inputCodeFromSMSTextLabel.bottomAnchor, constant: 15),
            sentPhoneNumberLabel.heightAnchor.constraint(equalToConstant: 25),
            
            verifyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            verifyView.topAnchor.constraint(equalTo: sentPhoneNumberLabel.bottomAnchor, constant: 25),
            verifyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            verifyView.heightAnchor.constraint(equalToConstant: 60)
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
    }
}

extension SMSCodeApprovePageViewController: VerifyProtocol {
    func verify() {
        let assembledCode = verifyView.assembleCode()
        if assembledCode.count == 6 {
            presenter.codeFromSMSRecieveAction(codeFromSMS: assembledCode)
        } else {
            return
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
