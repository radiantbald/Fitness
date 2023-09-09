//
//  MainPagePresenter.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 05.08.2023.
//

import Foundation
import Firebase

protocol MainPagePresenterDelegate: AnyObject {
    func sendPhoneNumber(_ phoneNumber: String)
    func showAuthAlert(error: Error)
}

final class MainPagePresenter {
    weak var delegate: MainPagePresenterDelegate?
    
    init(delegate: MainPagePresenterDelegate?) {
        self.delegate = delegate
    }
}

//MARK: - Input

extension MainPagePresenter {
    func sendPhoneNumberAction(_ phoneNumber: String) {
        
        Auth.auth().languageCode = "ru"
        Auth.auth().settings?.isAppVerificationDisabledForTesting = false
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] verificationID, error in
              if let verificationID = verificationID {
                  print(verificationID)
                  
                  let verificationID = VerificationIDModel(verificationID: verificationID)
                  guard let data = try? JSONEncoder().encode(verificationID) else { return }
                  Keychain.standart.set(data, forKey: "verificationID")
              }
              self?.reloadData(phoneNumber, error: error)
          }
    }
}

//MARK: - Output

extension MainPagePresenter {
    private func reloadData(_ phoneNumber: String, error: Error?) {
        print(error?.localizedDescription ?? "")
        DispatchQueue.main.async {
            if let error = error {
                self.delegate?.showAuthAlert(error: error)
                return
            }
            self.delegate?.sendPhoneNumber(phoneNumber)
        }
    }
}
