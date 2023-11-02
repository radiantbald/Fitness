//
//  VerifyView.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 30.10.2023.
//

import UIKit

protocol VerifyProtocol: AnyObject {
    func verify()
}

class VerifyView: UIView {
    
    weak var verifyProtocol: VerifyProtocol?
    
    var fieldStack = UIStackView()
    var verifyFields = [VerifyTextField]()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        setFieldsQuantity()
        setConstraints()
        verifyFields[0].becomeFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setFieldsQuantity() {
        addSubviews(fieldStack)
//        fieldStack.backgroundColor = .systemRed
        fieldStack.spacing = 20
        fieldStack.distribution = .fillEqually
        
        for number in 0...5 {
            let verifyTextField = VerifyTextField()
            verifyTextField.tag = number
            verifyTextField.fieldsProtocol = self
            verifyFields.append(verifyTextField)
            fieldStack.addArrangedSubview(verifyTextField)
            
        }
    }
    
    func assembleCode() -> String {
        var assembleCode = ""
        verifyFields.forEach { assembleCode.append($0.text ?? "") }
        return assembleCode
    }
}

extension VerifyView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            fieldStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            fieldStack.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            fieldStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            fieldStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        ])
    }
}

extension VerifyView: FieldsProtocol {

    func activateNextField(tag: Int) {
        if tag != verifyFields.count - 1 {
            verifyFields[tag + 1].becomeFirstResponder()
        } else {
            verifyProtocol?.verify()
        }
        if verifyFields[tag].text?.count != 0 {
            verifyFields[tag].backgroundColor = .systemRed
        }
    }
    
    func activatePreviousField(tag: Int) {
        if tag > 0 {
            verifyFields[tag - 1].text = ""
            verifyFields[tag - 1].becomeFirstResponder()
            verifyFields[tag - 1].backgroundColor = .systemGray5
        }
    }
    
    func disactivateFieldOnDeletingBackward(tag: Int) {
        if tag > 0 {
            verifyFields[tag].text = ""
            verifyFields[tag].backgroundColor = .systemGray5
            verifyFields[tag - 1].becomeFirstResponder()
        } else {
            verifyFields[tag].text = ""
            verifyFields[tag].backgroundColor = .systemGray5
            verifyFields[tag].becomeFirstResponder()
        }
    }
}
