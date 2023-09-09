//
//  Assembler.swift
//  MyOwnWorkout
//
//  Created by Алмаз Рахматуллин on 09.09.2023.
//

import Foundation

class Assembler {
    class var controllers: Controller.Type {
        return Controller.self
    }
}

class Controller {
    
    class var tabBar: TabBarViewController {
        return TabBarViewController()
    }
    
    
    class var main: MainPageViewController {
        let vc = MainPageViewController.storyboardInit
        let presenter = MainPagePresenter(delegate: vc)
        vc?.presenter = presenter
        return vc ??  MainPageViewController()
    }
    
    class var feed: FeedPageViewController {
        let vc = FeedPageViewController.storyboardInit
        let presenter = FeedPagePresenter(delegate: vc)
        vc?.presenter = presenter
        return vc ?? FeedPageViewController()
    }
    
    class var shedule: SchedulePageViewController {
        let vc = SchedulePageViewController.storyboardInit
        let presenter = SchedulePagePresenter(delegate: vc)
        vc?.presenter = presenter
        return vc ?? SchedulePageViewController()
    }
}
