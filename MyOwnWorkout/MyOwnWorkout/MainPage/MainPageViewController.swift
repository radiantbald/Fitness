//
//  ViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 20.05.2023.
//

import UIKit

class MainPageViewController: UIViewController {
    
    var isAuth: Bool = false

    @IBOutlet weak var mainPageAvatar: UIImageView!
    @IBOutlet weak var mainPageHeader: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func avatarButton(_ sender: UIButton) {
        view.backgroundColor = .white
        if isAuth {
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "PersonPageViewController") as! PersonPageViewController
            vc.modalPresentationStyle = .overFullScreen
            navigationController?.pushViewController(vc, animated: true)
            print("Личный кабинет")
        }
        
        else { //false
            let vc = storyboard?.instantiateViewController(withIdentifier: "RegPageViewController") as! RegPageViewController
            vc.modalPresentationStyle = .overFullScreen
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
            self.tabBarController?.tabBar.isHidden = true
            print("Страница регистрации")
        }
            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}


extension MainPageViewController: RegPageViewControllerDelegate {
    func getRegistration(surname: String, name: String, nick: String, phone: String) {
        print(surname, name, nick, phone)
    }
}
