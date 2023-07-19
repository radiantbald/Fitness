//
//  EntryPageViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 03.06.2023.
//

import UIKit

protocol EntryPageViewControllerDelegate: AnyObject {
    func getEntryData(nickname: String,
                      password: String)
    func toTheRegistrationPage()
}

class EntryPageViewController: ViewController {
    
    weak var delegate: EntryPageViewControllerDelegate?
    
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
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
        navigationItem.title = "Вход"
        print("Вы перешли на страницу авторизации")
    }
    
//    @IBAction func backButton(_ sender: UIButton) {
//        navigationController?.popViewController(animated: false)
//    }
    
    @IBAction func entryButton(_ sender: UIButton) {
        
        let nickname = nicknameTextField.text ?? ""
        let password = passwordTextField.text ?? ""

        if nickname == "0" && password == "0" {
            isAuth = true
            navigationController?.popToRootViewController(animated: false)
            delegate?.getEntryData(nickname: nickname, password: password)
        } else {
            showAlert(title: "Попробуйте еще раз", message: "Неверный никнейм или пароль")
        }
    }
    
    @IBAction func toTheRegistrationPageButton(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: false)
        delegate?.toTheRegistrationPage()
    }
}
