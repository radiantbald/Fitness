//
//  Date-Ext.swift
//  MyOwnWorkout
//
//  Created by Алмаз Рахматуллин on 19.02.2024.
//

import Foundation

extension Date {
    func toString(_ format:String! = "yyyy-MM-dd HH:mm:ss", _ convertTimeZone:Bool = false) -> String {
        let formatter = Formatter.default
        formatter.dateFormat = format
        if convertTimeZone {formatter.timeZone = Calendar.current.timeZone}
        return formatter.string(from: self)
    }
}
