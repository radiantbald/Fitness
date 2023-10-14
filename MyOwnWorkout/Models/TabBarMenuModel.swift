//
//  TabBarMenuModel.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 14.09.2023.
//

import Foundation

enum TabBarMenuModel: CaseIterable {
    
    case mainPage
    case schedulePage
    case feedPage
    
    var image: String {
        switch self {
        case .mainPage: return "homekit"
        case .schedulePage: return "calendar"
        case .feedPage: return "lineweight"
        }
    }
    
    var title: String {
        switch self {
        case .mainPage: return "Главная"
        case .schedulePage: return "Расписание"
        case .feedPage: return "Лента"
        }
    }
    
    var viewController: GeneralViewController {
        switch self {
        case .mainPage: return Assembler.controllers.mainPageViewController
        case .schedulePage: return Assembler.controllers.schedulePageViewController
        case .feedPage: return Assembler.controllers.feedPageViewController
        }
    }
    
}
