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
    
    @IBAction func avatarButton(_ sender: UIButton) {
        
        if isAuth == false {
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "PersonPageViewController") as! PersonPageViewController
            vc.modalPresentationStyle = .overFullScreen
            navigationController?.pushViewController(vc, animated: true)
            self.tabBarController?.tabBar.isHidden = true
            print("Личный кабинет")
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "RegPageViewController") as! RegPageViewController
            vc.modalPresentationStyle = .overFullScreen
            navigationController?.pushViewController(vc, animated: true)
            self.tabBarController?.tabBar.isHidden = true
            print("Страница регистрации")
            
        }
            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

