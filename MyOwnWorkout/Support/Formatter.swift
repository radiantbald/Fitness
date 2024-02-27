//
//  Formatter.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 25.02.2024.
//

import Foundation

class Formatter {
    private let dateFormatter = DateFormatter()
    private init() {}
    static let `default`: Formatter = Formatter()
    
    var dateFormat: String! {
        get { return dateFormatter.dateFormat }
        set { dateFormatter.dateFormat = newValue }
    }
    
    var timeZone: TimeZone! {
        get { return dateFormatter.timeZone }
        set { dateFormatter.timeZone = newValue }
    }
    
    func string(from date: Date) -> String {
        dateFormatter.locale = Locale(identifier: "ru")
        return dateFormatter.string(from: date)
    }
}
