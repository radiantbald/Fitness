//
//  SMSCodeApprovePagePresenter.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 05.08.2023.
//

import Foundation
import Firebase

protocol SMSCodeApprovePagePresenterDelegate: AnyObject {
    func successAuth()
    func showAuthAlert(error: Error)
}

final class SMSCodeApprovePagePresenter {
    weak var delegate: SMSCodeApprovePagePresenterDelegate?
    
    init(delegate: SMSCodeApprovePagePresenterDelegate?) {
        self.delegate = delegate
    }
}

//MARK: - Input

extension SMSCodeApprovePagePresenter {
    
    func codeFromSMSRecieveAction(codeFromSMS: String) {
        
        guard let data = Keychain.standart.getData(KeychainKeys.VerificationID.rawValue) else { return }
        guard let verificationID = try? JSONDecoder().decode(VerificationIDModel.self, from: data) else { return }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID.verificationID, verificationCode: codeFromSMS)
        
        Auth.auth().signIn(with: credential) { [weak self] authData, error in
            if let error = error {
                DispatchQueue.main.async {
                    print(error)
                    self?.delegate?.showAuthAlert(error: error)
                    
                }
                return
            }
            if let authData = authData {
                DispatchQueue.main.async {
                    self?.delegate?.successAuth()
                    print(authData.user)
                }
                
            }
            
        }
    }
}

//MARK: - Output

extension SMSCodeApprovePagePresenter {
    
}
