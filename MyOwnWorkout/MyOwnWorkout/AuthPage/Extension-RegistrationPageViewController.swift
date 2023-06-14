//
//  Extension-RegistrationPageViewController.swift
//  MyOwnWorkout
//
//  Created by Алмаз Рахматуллин on 14.06.2023.
//

import UIKit

//MARK: - Text Field
extension RegistrationPageViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {

    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if textField == phoneNumberTextField {
            textField.text = text.phoneMask()
        }
    }
}
