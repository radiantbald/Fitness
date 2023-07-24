//
//  ViewController.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 20.05.2023.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainPageAvatar: UIImageView!
    @IBOutlet weak var mainPageHeader: UILabel!
    
    @IBAction func avatarButton(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PersonVC") as! PersonViewController
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

