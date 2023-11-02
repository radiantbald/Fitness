//
//  VerifyTextField.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 30.10.2023.
//

import UIKit

protocol FieldsProtocol: AnyObject {
    func activateNextField(tag: Int)
    func activatePreviousField(tag: Int)
    func disactivateFieldOnDeletingBackward(tag: Int)
}

class VerifyTextField: UITextField {
    
    weak var fieldsProtocol: FieldsProtocol?
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        backgroundColor = .systemGray5
        layer.cornerRadius = 10
        tintColor = .clear
        textColor = .white
        layer.borderColor = UIColor.black.cgColor
        font = UIFont(name: Fonts.main.rawValue, size: 36)
        textAlignment = .center
        
    }
    
    override func deleteBackward() {
        fieldsProtocol?.activatePreviousField(tag: tag)
    }
}

extension VerifyTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        text = string
        
        if range.length == 0 {
            fieldsProtocol?.activateNextField(tag: tag)
            textField.resignFirstResponder()
        }
        if text?.count == 0 {
            fieldsProtocol?.disactivateFieldOnDeletingBackward(tag: tag)
        }
        return false
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let end = textField.endOfDocument
        textField.selectedTextRange = textField.textRange(from: end, to: end)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        layer.borderWidth = 2
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        layer.borderWidth = 0
    }
}
