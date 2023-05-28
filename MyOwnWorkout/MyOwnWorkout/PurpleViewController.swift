//
//  PurpleViewController.swift
//  MyOwnWorkout
//
//  Created by Алмаз Рахматуллин on 28.05.2023.
//

import UIKit

class PurpleViewController: UIViewController, ChildrenViewControllerDelegate {
    func editText(text: String?) {
        button.setTitle(text, for: .normal)
    }
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
    }
    
    
    @IBAction func pushButton(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ChildrenViewController") as! ChildrenViewController
        vc.delegate = self
        present(vc, animated: true)
    }
    
    
    
}

