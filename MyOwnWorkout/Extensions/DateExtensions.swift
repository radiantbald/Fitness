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
    
    func getDateWithOffset(with offset: Int) -> Date {
        let calendar = Calendar.current
        let offsetDate = calendar.date(byAdding: .day, value: offset, to: self) ?? Date()
        return offsetDate
    }
    
    func convertDateToModel() -> DateModel {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru")
        formatter.dateFormat = "EEEEEE"
        
        let numberOfDay = calendar.component(.day, from: self)
        let dayOfWeek = formatter.string(from: self)
        
        return DateModel(numberOfDay: String(numberOfDay),
                         dayOfWeek: dayOfWeek,
                         monthName: self.getMonthFromDate(),
                         dateString: self.dateFormatddMMyyyy())
    }
    
    func getMonthFromDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru")
        formatter.dateFormat = "LLLL yyyy"
        let monthName = formatter.string(from: self)
        return monthName
    }
    
    func dateFormatddMMyyyy() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru")
        formatter.dateFormat = "dd/MM/yyyy"
        let format = formatter.string(from: self)
        return format
    }
}
