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
    
    @IBOutlet weak var codeFromSMSTextField: UITextField!
    
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
        navigationItem.title = "Код авторизации"
        print("Вы перешли на страницу ввода СМС кода")
        
        codeFromSMSTextField.delegate = self
        codeFromSMSTextField.textAlignment = .center
    }
    
    @IBAction func registrationButtonAction(_ sender: UIButton) {
        
        let codeFromSMS = codeFromSMSTextField.text ?? ""
        
        if codeFromSMS.setOnlyNumbers(string: codeFromSMS) == "000000" {
            print("Вы вошли в аккаунт")
            isAuth = true
            navigationController?.popToRootViewController(animated: false)
            delegate?.getCodeFromSMS(codeFromSMS: codeFromSMS)
        } else {
            print("Неправильный код")
        }
    }
}

//MARK: - Extensions

extension SMSCodeApprovePageViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if textField == codeFromSMSTextField {
            textField.text = text.codeFromSMSMask()
        }
    }
}

extension SMSCodeApprovePageViewController: SMSCodeApprovePagePresenterDelegate {

}
