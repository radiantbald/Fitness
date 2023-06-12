//
//  FeedPageViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 03.06.2023.
//

import UIKit

class FeedPageViewController: UIViewController {
   
    var isAuth: Bool = false
    
    @IBOutlet weak var feedPageAvatar: UIImageView!
    @IBOutlet weak var feedPageHeader: UILabel!
    
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
}

extension FeedPageViewController: RegistrationPageViewControllerDelegate {
    func getRegistrationData(name: String, surname: String, phoneNumber: String, password: String, nickname: String) {
        print(name, surname, phoneNumber, password, nickname)
        let vc = storyboard?.instantiateViewController(withIdentifier: "RegistrationApprovePageViewController") as! RegistrationApprovePageViewController
//        vc.delegate = self
        navigationController?.pushViewController(vc, animated: false)
    }
    func toTheEntryPage() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EntryPageViewController") as! EntryPageViewController
        //        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}
