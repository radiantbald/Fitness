//
//  ViewController.swift
//  MyOwnWorkout
//
//  Created by Алмаз Рахматуллин on 19.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var isAuth: Bool {
        get {
            return DataBase.isAuth
        }
        set {
            DataBase.isAuth = newValue
        }
    }
}
