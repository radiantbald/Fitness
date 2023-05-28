//
//  ChildrenViewController.swift
//  MyOwnWorkout
//
//  Created by Алмаз Рахматуллин on 28.05.2023.
//


import UIKit

protocol ChildrenViewControllerDelegate: AnyObject {
    func editText(text: String?)
}

class ChildrenViewController: UIViewController {
     weak var delegate: ChildrenViewControllerDelegate?
    
    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func editButton(_ sender: UIButton) {
        guard let text = textField.text else { return }
        delegate?.editText(text: text)
        
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
        
    }
    
    
}

