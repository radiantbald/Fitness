//
//  CalendarModel.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 27.02.2024.
//

import Foundation

class CalendarModel {
    
    private func getDaysArray(date: Date) -> [Date] {
        var daysArray = [Date]()
        for day in -10...10 {
            let day = date.getDateWithOffset(with: day)
            daysArray.append(day)
        }
        return daysArray
    }
    
    public func getWeekForCalendar(date: Date) -> [DateModel] {
        let daysArray = getDaysArray(date: date)
        let dateModelsArray = daysArray.map { $0.convertDateToModel() }
        return dateModelsArray
    }
}
