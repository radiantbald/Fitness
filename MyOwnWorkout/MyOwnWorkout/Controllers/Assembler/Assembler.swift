//
//  Assembler.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 14.09.2023.
//

import Foundation

class Assembler {
    class var controllers: Controllers.Type {
        return Controllers.self
    }
}

class Controllers {
    
    class var tabBarController: TabBarController {
        return TabBarController()
    }
    
    class var mainPageViewController: MainPageViewController {
        let viewController = MainPageViewController.storyboardInit
        let presenter = MainPagePresenter(delegate: viewController)
        viewController?.presenter = presenter
        return viewController ?? MainPageViewController()
    }
    
    class var schedulePageViewController: SchedulePageViewController {
        let viewController = SchedulePageViewController.storyboardInit
        let presenter = SchedulePagePresenter(delegate: viewController)
        viewController?.presenter = presenter
        return viewController ?? SchedulePageViewController()
    }
    
    class var feedPageViewController: FeedPageViewController {
        let viewController = FeedPageViewController.storyboardInit
        let presenter = FeedPagePresenter(delegate: viewController)
        viewController?.presenter = presenter
        return FeedPageViewController.storyboardInit ?? FeedPageViewController()
    }
    
    class var registrationPageViewController: RegistrationPageViewController {
        return RegistrationPageViewController.storyboardInit ?? RegistrationPageViewController()
    }
    
    class var entryPageViewController: EntryPageViewController {
        return EntryPageViewController.storyboardInit ?? EntryPageViewController()
    }
    
    class var smsCodeApprovePageViewController: SMSCodeApprovePageViewController {
        return SMSCodeApprovePageViewController.storyboardInit ?? SMSCodeApprovePageViewController()
    }
    
    class var personPageViewController: PersonPageViewController {
        return PersonPageViewController.storyboardInit ?? PersonPageViewController()
    }
    
    class var trainigProgramsPageViewController: TrainigProgramsPageViewController {
        return TrainigProgramsPageViewController.storyboardInit ?? TrainigProgramsPageViewController()
    }
    
    class var myWorkoutsPageViewController: MyWorkoutsPageViewController {
        return MyWorkoutsPageViewController.storyboardInit ?? MyWorkoutsPageViewController()
    }
    
    class var myExercisesPageViewController: MyExercisesPageViewController {
        return MyExercisesPageViewController.storyboardInit ?? MyExercisesPageViewController()
    }
    
    class var myAchievmentsPageViewController: MyAchievmentsPageViewController {
        return MyAchievmentsPageViewController.storyboardInit ?? MyAchievmentsPageViewController()
    }
    
    class var personalAccountPageViewController: PersonalAccountPageViewController {
        return PersonalAccountPageViewController.storyboardInit ?? PersonalAccountPageViewController()
    }
    
    class var aboutAppPageViewController: AboutAppPageViewController {
        return AboutAppPageViewController.storyboardInit ?? AboutAppPageViewController()
    }
    
    class var settingsPageViewController: SettingsPageViewController {
        return SettingsPageViewController.storyboardInit ?? SettingsPageViewController()
    }
}


