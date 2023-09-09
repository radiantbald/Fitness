//
//  MenuModel.swift
//  MyOwnWorkout
//
//  Created by Алмаз Рахматуллин on 09.09.2023.
//

import Foundation

enum Menu: CaseIterable {
    case main
    case schedule
    case feed
    
    var image: String {
        switch self {
        case .main: return "homekit"
        case .schedule: return "calendar"
        case .feed: return "lineweight"
        }
    }
    
    var title: String {
        switch self {
        case .main: return "Главная"
        case .schedule: return "Расписание"
        case .feed: return "Лента"
        }
    }
    
    var viewController: GeneralViewController {
        switch self {
        case .main: return Assembler.controllers.main
        case .schedule: return Assembler.controllers.shedule
        case .feed: return Assembler.controllers.feed
        }
    }
}
