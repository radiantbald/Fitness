//
//  AuthPageViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 03.06.2023.
//

import UIKit

//protocol TestProtocol: AnyObject {
//
//}
//
//class Test {
//    weak var delegate: TestProtocol?
//}

protocol RegPageViewControllerDelegate: AnyObject {
    func getRegistration(surname: String, name: String, nick: String, phone: String)
}

class RegPageViewController: UIViewController {
    weak var delegate: RegPageViewControllerDelegate?
    
//    let test = Test()
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nickTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    //1
    override func loadView() {
        super.loadView()
//        print(#function)
//        test.delegate = self
    }
    
    //2
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Регистрация"
//        print(#function)
    }
    
    //3
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
//        print(#function)
    }
    
    //4
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        print(#function)
    }
    
    //5
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
//        print(#function)
    }
    
    
    //6
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        print(#function)
    }
    
    //7
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        print(#function)
    }
    
    //8
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        print(#function)
        
    }
    
    //9
    deinit {
//        print(#function)
    }
    
    
    @IBAction func EntryButton(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "EntryPageViewController") as! EntryPageViewController
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func registrationButton(_ sender: UIButton) {
        //TODO: если нет какого то поля то распечатать текст что нет таких то данных. Если все ОК то печатать success
        
        //1
        let surname = surnameTextField.text ?? "-"
        let name = nameTextField.text ?? "-"
        let nick = nickTextField.text ?? "-"
        let phone = phoneTextField.text ?? "-"
        
        //2 передать на главную
            //2-1 delegate
        delegate?.getRegistration(surname: surname, name: name, nick: nick, phone: phone)
        
        //3 уйти из этого экрана
        navigationController?.popToRootViewController(animated: true)
    }
    
    
}

//MARK: - Text Field
extension RegPageViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print(textField.text)
    }
}
