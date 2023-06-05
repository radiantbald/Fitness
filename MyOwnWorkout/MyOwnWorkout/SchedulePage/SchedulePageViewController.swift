//
//  SchedulePageViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 03.06.2023.
//

import UIKit

class SchedulePageViewController: UIViewController {

    var isAuth: Bool = true
    
    @IBOutlet weak var schedulePageAvatar: UIImageView!
    @IBOutlet weak var schedulePageHeader: UILabel!
    
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
