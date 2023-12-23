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
        let viewController = MainPageViewController()
        let presenter = MainPagePresenter(delegate: viewController)
        viewController.presenter = presenter
        return viewController
    }
    
    class var schedulePageViewController: SchedulePageViewController {
        let viewController = SchedulePageViewController()
        let presenter = SchedulePagePresenter(delegate: viewController)
        viewController.presenter = presenter
        return viewController
    }
    
    class var feedPageViewController: FeedPageViewController {
        let viewController = FeedPageViewController()
        let presenter = FeedPagePresenter(delegate: viewController)
        viewController.presenter = presenter
        return viewController
    }
    
    class var entryPageViewController: EntryPageViewController {
        let viewController = EntryPageViewController()
        let presenter = EntryPagePresenter(delegate: viewController)
        viewController.presenter = presenter
        return viewController
    }
    
    class var smsCodeApprovePageViewController: SMSCodeApprovePageViewController {
        let viewController = SMSCodeApprovePageViewController()
        let presenter = SMSCodeApprovePagePresenter(delegate: viewController)
        viewController.presenter = presenter
        return viewController 
    }
    
    class var personPageViewController: PersonPageViewController {
        let viewController = PersonPageViewController()
        let presenter = PersonPagePresenter(delegate: viewController)
        viewController.presenter = presenter
        return viewController
    }
    
    class var trainingProgramsPageViewController: TrainingProgramsPageViewController {
        let viewController = TrainingProgramsPageViewController()
        let presenter = TrainingProgramsPagePresenter(delegate: viewController)
        viewController.presenter = presenter
        return viewController
    }
    
    class var myWorkoutsPageViewController: MyWorkoutsPageViewController {
        let viewController = MyWorkoutsPageViewController()
        let presenter = MyWorkoutsPagePresenter(delegate: viewController)
        viewController.presenter = presenter
        return viewController
    }
    
    class var myExercisesPageViewController: MyExercisesPageViewController {
        let viewController = MyExercisesPageViewController()
        let presenter = MyExercisesPagePresenter(delegate: viewController)
        viewController.presenter = presenter
        return viewController
    }
    
    class var myAchievmentsPageViewController: MyAchievmentsPageViewController {
        let viewController = MyAchievmentsPageViewController()
        let presenter = MyAchievmentsPagePresenter(delegate: viewController)
        viewController.presenter = presenter
        return viewController
    }
    
    class var personalAccountPageViewController: PersonalAccountPageViewController {
        let viewController = PersonalAccountPageViewController()
        let presenter = PersonalAccountPagePresenter(delegate: viewController)
        viewController.presenter = presenter
        return viewController
    }
    
    class var aboutAppPageViewController: AboutAppPageViewController {
        let viewController = AboutAppPageViewController()
        let presenter = AboutAppPagePresenter(delegate: viewController)
        viewController.presenter = presenter
        return viewController
    }
    
    class var settingsPageViewController: SettingsPageViewController {
        let viewController = SettingsPageViewController()
        let presenter = SettingsPagePresenter(delegate: viewController)
        viewController.presenter = presenter
        return viewController
    }
    
    class var addExercisePageViewController: AddExercisePageViewController {
        let viewController = AddExercisePageViewController()
        let presenter = AddExercisePagePresenter(delegate: viewController)
        viewController.presenter = presenter
        return viewController
    }
    
    class func setupExercisePageViewController(parent: SetupExercisePageViewControllerDelegate?, exercise: ExerciseModel) -> SetupExercisePageViewController {
        let viewController = SetupExercisePageViewController(parent: parent, exercise: exercise)
        let presenter = SetupExercisePagePresenter(delegate: viewController)
        viewController.presenter = presenter
        return viewController
    }
    
    class var exercisePageViewController: ExercisePageViewController {
        let viewController = ExercisePageViewController()
        let presenter = ExercisePagePresenter(delegate: viewController)
        viewController.presenter = presenter
        return viewController
    }
}


