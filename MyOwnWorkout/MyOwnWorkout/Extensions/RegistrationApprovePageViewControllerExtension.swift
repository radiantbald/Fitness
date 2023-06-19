//
//  RegistrationApprovePageViewControllerExtension.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 16.06.2023.
//

import UIKit

//MARK: UITextFieldDelegate

extension RegistrationApprovePageViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if textField == codeFromSMSTextField {
            textField.text = text.codeFromSMSMask()
        }
    }
}
