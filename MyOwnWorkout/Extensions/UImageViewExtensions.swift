//
//  UImageViewExtensions.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 14.10.2023.
//

import UIKit

extension UIImageView {
    
    convenience init(_ height: Double,
                     _ width: Double) {
        self.init()
        self.frame.size.height = height
        self.frame.size.width = width
    }
}
