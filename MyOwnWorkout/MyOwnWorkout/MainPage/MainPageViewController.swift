//
//  ViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 20.05.2023.
//

import UIKit

class MainPageViewController: UIViewController {
    
    var isAuth: Bool = true

    @IBOutlet weak var mainPageAvatar: UIImageView!
    @IBOutlet weak var mainPageHeader: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        print("Вы перешли на Главную страницу")
        
    }
    
    @IBAction func avatarButton(_ sender: UIButton) {
        
        if isAuth == false {
            let vc = storyboard?.instantiateViewController(withIdentifier: "PersonPageViewController") as! PersonPageViewController
            vc.modalPresentationStyle = .overFullScreen
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "RegistrationPageViewController") as! RegistrationPageViewController
            vc.modalPresentationStyle = .overFullScreen
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}

//MARK: - RegistrationPageViewControllerDelegate
extension MainPageViewController {
    func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backButtonTitle = "Назад"
    }
}
extension MainPageViewController: RegistrationPageViewControllerDelegate {
    func getRegistrationData(name: String, surname: String, phoneNumber: String, password: String, nickname: String) {
        print(name, surname, phoneNumber, password, nickname)
        let vc = storyboard?.instantiateViewController(withIdentifier: "RegistrationApprovePageViewController") as! RegistrationApprovePageViewController
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: false)
    }
    func toTheEntryPage() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EntryPageViewController") as! EntryPageViewController
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: false)
    }
}

//MARK: - RegistrationApprovePageViewControllerDelegate

extension MainPageViewController: RegistrationApprovePageViewControllerDelegate {
    func getCodeFromSMS(codeFromSMS: String) {
        print(codeFromSMS)
        let vc = storyboard?.instantiateViewController(withIdentifier: "PersonPageViewController") as! PersonPageViewController
        navigationController?.pushViewController(vc, animated: false)
    }
}

//MARK: - EntryPageViewControllerDelegate

extension MainPageViewController: EntryPageViewControllerDelegate {
    func getEntryData(nickname: String, password: String) {
        print(nickname, password)
        let vc = storyboard?.instantiateViewController(withIdentifier: "PersonPageViewController") as! PersonPageViewController
        navigationController?.pushViewController(vc, animated: false)
    }
}
