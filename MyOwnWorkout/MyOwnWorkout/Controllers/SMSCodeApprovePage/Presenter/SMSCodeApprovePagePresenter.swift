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
    func errorAlert(error: Error)
}

final class SMSCodeApprovePagePresenter {
    
    weak var delegate: SMSCodeApprovePagePresenterDelegate?
    
}

//MARK: - Input

extension SMSCodeApprovePagePresenter {
    
    func codeFirebase(code: String) {
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") ?? ""
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID,
                                                                 verificationCode: code)
        print(credential)
        
        Auth.auth().signIn(with: credential) { [weak self] authData, error in
            if let error = error {
                // Handles error
                DispatchQueue.main.async {
                    self?.delegate?.errorAlert(error: error)
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
