//
//  EntryPageViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 03.06.2023.
//

import UIKit

class EntryPageViewController: UIViewController {

    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
//        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
