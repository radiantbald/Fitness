//
//  FeedPageViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 03.06.2023.
//

import UIKit

class FeedPageViewController: UIViewController {
    
    private var isAuth: Bool {
        get {
            return DataBase.isAuth
        }
        set {
            DataBase.isAuth = newValue
            view.backgroundColor = newValue ? UIColor.systemOrange : .white
            authLabel.text = newValue ? "Авторизован" : "Не авторизован"
        }
    }
    
    @IBOutlet weak var feedPageAvatar: UIImageView!
    @IBOutlet weak var feedPageHeader: UILabel!
    @IBOutlet weak var authLabel: UILabel!
    @IBOutlet weak var exitButton: UIButton!
    
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
        authLabel.text = isAuth ? "Авторизован" : "Не авторизован"
        print("Вы перешли на страницу с лентой новостей")
        
    }
    
    @IBAction func avatarButton(_ sender: UIButton) {
        
        if isAuth {
            
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
    
    @IBAction func exitButtonAction(_ sender: UIButton) {
        let status = !isAuth
        isAuth = status
    }
    
    
}

//MARK: - RegistrationPageViewControllerDelegate

extension FeedPageViewController: RegistrationPageViewControllerDelegate {
    func getRegistrationData(name: String, surname: String, phoneNumber: String, password: String, nickname: String) {
        print(name, surname, phoneNumber, password, nickname)
        let vc = storyboard?.instantiateViewController(withIdentifier: "RegistrationApprovePageViewController") as! RegistrationApprovePageViewController
//        vc.delegate = self
        navigationController?.pushViewController(vc, animated: false)
    }
    func toTheEntryPage() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EntryPageViewController") as! EntryPageViewController
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - RegistrationApprovePageViewControllerDelegate

extension FeedPageViewController: RegistrationApprovePageViewControllerDelegate {
    func getCodeFromSMS(codeFromSMS: String) {
        print(codeFromSMS)
        let vc = storyboard?.instantiateViewController(withIdentifier: "PersonPageViewController") as! PersonPageViewController
        navigationController?.pushViewController(vc, animated: false)
    }
}

//MARK: - EntryPageViewControllerDelegate

extension FeedPageViewController: EntryPageViewControllerDelegate {
    func getEntryData(nickname: String, password: String) {
        print(nickname, password)
        let vc = storyboard?.instantiateViewController(withIdentifier: "PersonPageViewController") as! PersonPageViewController
        navigationController?.pushViewController(vc, animated: false)
    }
}
