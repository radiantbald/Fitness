//
//  AddExerciseAlert.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 15.10.2023.
//

import UIKit

class AddExerciseAlert {
    
    static func showAddExerciseAlert(viewController: UIViewController,
                                     title: String,
                                     completionHandler: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Название"
        }
        
        let okButton = UIAlertAction(title: "Добавить", style: .default) { _ in
            guard let textFields = alertController.textFields else { return }
            let exerciseName = textFields.compactMap{$0.text}.joined()

            completionHandler(exerciseName)
        }
        
        let cancelButton = UIAlertAction(title: "Отменить", style: .destructive)

        alertController.addAction(okButton)
        alertController.addAction(cancelButton)
                
        DispatchQueue.main.async {
            viewController.present(alertController, animated: true)
        }
    }
}
