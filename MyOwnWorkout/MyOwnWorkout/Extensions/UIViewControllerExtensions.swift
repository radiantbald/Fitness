//
//  UIViewControllerExtentions.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 16.06.2023.
//

import UIKit

extension UIViewController {
    class var classIdentifier: String { return String(describing: Self.self) }
    
    class var storyboardInit: Self? {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: Self.classIdentifier) as? Self
        return viewController
    }
    
    func showAlert(title: String?, message: String?) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Закрыть", style: .cancel)
        alertVC.addAction(cancel)
        present(alertVC, animated: true)
    }
}
