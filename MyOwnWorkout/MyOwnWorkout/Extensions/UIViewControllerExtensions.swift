//
//  UIViewControllerExtentions.swift
//  MyOwnWorkout
//
//  Created by Radiant Bald on 16.06.2023.
//

import UIKit

extension UIViewController {
    class var identifier: String { return String(describing: Self.self)}
    
    func showAlert(title: String?, message: String?) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Закрыть", style: .cancel)
        alertVC.addAction(cancel)
        present(alertVC, animated: true)
    }
    
    
    class var initInStoryboard: Self? {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: Self.identifier) as? Self
        return vc
    }
    
}
