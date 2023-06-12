//
//  RegistrationApproveViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 12.06.2023.
//

import UIKit

class RegistrationApprovePageViewController: UIViewController {
    
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
    }
    
    @IBAction func registrationButton(_ sender: UIButton) {
        
        let codeFromSMS = codeFromSMSTextField.text ?? ""
        
        if codeFromSMS == "000000" {
            print("Введенный код корректен")
            let vc = storyboard?.instantiateViewController(withIdentifier: "PersonPageViewController") as! PersonPageViewController
    //        vc.delegate = self
            
            //MARK: - TODO: переделать путь делегатом через rootViewController
            navigationController?.pushViewController(vc, animated: true)
            
        } else {
            print("Неправильный код")
        }
    }
}

//MARK: - Text Field
extension RegistrationApprovePageViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {

    }
}
