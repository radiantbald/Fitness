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
