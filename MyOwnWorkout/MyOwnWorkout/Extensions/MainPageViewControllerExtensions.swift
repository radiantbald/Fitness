//
//  MainPageViewControllerExtentions.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 16.06.2023.
//

import UIKit

//MARK: RegistrationPageViewControllerDelegate

extension MainPageViewController: RegistrationPageViewControllerDelegate {
    func getRegistrationData(name: String, surname: String, phoneNumber: String, password: String, nickname: String) {
        print(name, surname, phoneNumber, password, nickname)
        let vc = storyboard?.instantiateViewController(withIdentifier: "RegistrationApprovePageViewController") as! RegistrationApprovePageViewController
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: false)
    }
    func toTheEntryPage() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EntryPageViewController") as! EntryPageViewController
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: RegistrationApprovePageViewControllerDelegate

extension MainPageViewController: RegistrationApprovePageViewControllerDelegate {
    func getCodeFromSMS(codeFromSMS: String) {
        print(codeFromSMS)
        let vc = storyboard?.instantiateViewController(withIdentifier: "PersonPageViewController") as! PersonPageViewController
        navigationController?.pushViewController(vc, animated: false)
    }
}

//MARK: EntryPageViewControllerDelegate

extension MainPageViewController: EntryPageViewControllerDelegate {
    func getEntryData(nickname: String, password: String) {
        print(nickname, password)
        let vc = storyboard?.instantiateViewController(withIdentifier: "PersonPageViewController") as! PersonPageViewController
        navigationController?.pushViewController(vc, animated: false)
    }
}
