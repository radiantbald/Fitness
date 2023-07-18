//
//  SchedulePageViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 03.06.2023.
//

import UIKit

class SchedulePageViewController: UIViewController {

    private var isAuth: Bool {
        get {
            return DataBase.isAuth
        }
        set {
            DataBase.isAuth = newValue
        }
    }
    
    @IBOutlet weak var schedulePageAvatar: UIImageView!
    @IBOutlet weak var schedulePageHeader: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
        print("Вы перешли на страницу с расписанием")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    @IBAction func avatarButton(_ sender: UIButton) {
        
        if isAuth {
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "PersonPageViewController") as! PersonPageViewController
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "EntryPageViewController") as! EntryPageViewController
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}

extension SchedulePageViewController {
    func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backButtonTitle = "Назад"
    }
}
//MARK: - RegistrationPageViewControllerDelegate

extension SchedulePageViewController: RegistrationPageViewControllerDelegate {
    func getRegistrationData(name: String, surname: String, phoneNumber: String, password: String, nickname: String) {
        print(name, surname, phoneNumber, password, nickname)
        let vc = storyboard?.instantiateViewController(withIdentifier: "RegistrationApprovePageViewController") as! RegistrationApprovePageViewController
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: false)
    }
    func toTheEntryPage() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EntryPageViewController") as! EntryPageViewController
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - RegistrationApprovePageViewControllerDelegate

extension SchedulePageViewController: RegistrationApprovePageViewControllerDelegate {
    func getCodeFromSMS(codeFromSMS: String) {
        print(codeFromSMS)
        let vc = storyboard?.instantiateViewController(withIdentifier: "PersonPageViewController") as! PersonPageViewController
        navigationController?.pushViewController(vc, animated: false)
    }
}

//MARK: - EntryPageViewControllerDelegate

extension SchedulePageViewController: EntryPageViewControllerDelegate {
    func getEntryData(nickname: String, password: String) {
        print(nickname, password)
        let vc = storyboard?.instantiateViewController(withIdentifier: "PersonPageViewController") as! PersonPageViewController
        navigationController?.pushViewController(vc, animated: false)
    }
    func toTheRegistrationPage() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "RegistrationPageViewController") as! RegistrationPageViewController
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: false)
    }
}
