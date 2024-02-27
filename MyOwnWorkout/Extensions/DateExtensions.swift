//
//  DateExtensions.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 25.02.2024.
//

import Foundation

extension Date {
    func toString(_ format: String! = "") -> String {
        let formatter = Formatter.default
        formatter.dateFormat = format

        return formatter.string(from: self)
    }
}
