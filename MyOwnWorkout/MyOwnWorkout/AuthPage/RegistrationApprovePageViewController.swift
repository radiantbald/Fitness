//
//  RegistrationApproveViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 12.06.2023.
//

import UIKit

protocol RegistrationApprovePageViewControllerDelegate: AnyObject {
    func getCodeFromSMS(codeFromSMS: String)
}

class RegistrationApprovePageViewController: UIViewController {
    
    weak var delegate: RegistrationApprovePageViewControllerDelegate?
    
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
        navigationItem.title = "Регистрация"
        print("Вы перешли на страницу подтверждения регистрации")
        
        codeFromSMSTextField.delegate = self
        codeFromSMSTextField.textAlignment = .center
    }
    
    @IBAction func registrationButton(_ sender: UIButton) {
        
        let codeFromSMS = codeFromSMSTextField.text ?? ""
        
        if codeFromSMS.setOnlyNumbers(string: codeFromSMS) == "000000" {
            print("Введенный код корректен")
            
            navigationController?.popToRootViewController(animated: false)
            
            delegate?.getCodeFromSMS(codeFromSMS: codeFromSMS)
            
        } else {
            print("Неправильный код")
        }
    }
}
