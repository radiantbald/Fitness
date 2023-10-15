//
//  UIViewExtensions.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 14.10.2023.
//

import UIKit

extension UIView {
    
    convenience init (_ color: UIColor) {
        self.init()
        self.backgroundColor = color
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach({
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
    }
}
