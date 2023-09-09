//
//  MainPagePresenter.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 05.08.2023.
//

import Foundation
import Firebase


protocol MainPagePresenterDelegate: AnyObject {
    func pushForCodeVC(_ number: String)
    func showAlertError(error: Error)
}

final class MainPagePresenter {
    weak var delegate: MainPagePresenterDelegate?
}

//MARK: - Input

extension MainPagePresenter {
    func pushForSMSCode(_ number: String) {
        Auth.auth().languageCode = "ru";
        Auth.auth().settings?.isAppVerificationDisabledForTesting = false
        PhoneAuthProvider.provider()
          .verifyPhoneNumber(number, uiDelegate: nil) { [weak self] verificationID, error in
              if let verificationID = verificationID {
                  UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
              }
              
              self?.reloadData(number, error: error)
          }
    }
}

//MARK: - Output

extension MainPagePresenter {
    private func reloadData(_ number: String, error: Error?) -> Void {
        print(error?.localizedDescription ?? "----")
        
        DispatchQueue.main.async {
            if let error = error {
                self.delegate?.showAlertError(error: error)
                return
            }
            
            self.delegate?.pushForCodeVC(number)
        }
    }
}
