//
//  SheduleViewController.swift
//  MyOwnWorkout
//
//  Created by Алмаз Рахматуллин on 28.05.2023.
//

import UIKit


class SheduleViewController: UIViewController, ChildrenViewControllerDelegate {
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
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


