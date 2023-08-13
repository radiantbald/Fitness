//
//  PersonPagePresenter.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 05.08.2023.
//

import Foundation

protocol PersonPagePresenterDelegate: AnyObject {
    func setupAvatar()
    func avatarTap()
    func setupMenu()
    func openTrainingProgramsPage()
    func openMyWorkoutsPage()
    func openMyExercisesPage()
    func openMyAchievmentsPage()
    func openPersonalAccountPage()
    func openSettingsPage()
    func openAboutAppPage()
    func exit()
}

final class PersonPagePresenter {

    weak var delegate: PersonPagePresenterDelegate?
    
    private func setupAvatarAction() {
        delegateSetupAvatar()
    }
    private func avatarTapAction() {
        delegateAvatarTap()
    }
    private func setupMenuAction() {
        delegateSetupMenu()
    }
    private func openTrainingProgramsPageAction() {
        print("Вы переходите на страницу Тренировочных программ")
        delegateOpenTrainingProgramsPage()
    }
    private func openMyWorkoutsPageAction() {
        print("Вы переходите на страницу Своих тренировок")
        delegateOpenMyWorkoutsPage()
    }
    private func openMyExercisesPageAction() {
        print("Вы переходите на страницу Своих упражнений")
        delegateOpenMyExercisesPage()
    }
    private func openMyAchievmentsPageAction() {
        print("Вы переходите на страницу Своих достижений")
        delegateOpenMyAchievmentsPage()
    }
    private func openPersonalAccountPageAction() {
        print("Вы переходите на страницу Лицевого счета")
        delegateOpenPersonalAccountPage()
    }
    private func openSettingsPageAction() {
        print("Вы переходите на страницу настроек")
        delegateOpenSettingsPage()
    }
    private func openAboutAppPageAction() {
        print("Вы переходите на страницу 'О приложении'")
        delegateOpenAboutAppPage()
    }
    private func exitAction() {
        DataBase.isAuth = false
        print("Вы вышли из аккаунта")
        delegateExit()
    }
}

//MARK: - Input

extension PersonPagePresenter {

    func setupAvatar() {
        setupAvatarAction()
    }
    func avatarTap() {
        avatarTapAction()
    }
    func setupMenu() {
        setupMenuAction()
    }
    func openTrainingProgramsPage() {
        openTrainingProgramsPageAction()
    }
    func openMyWorkoutsPage() {
        openMyWorkoutsPageAction()
    }
    func openMyExercisesPage() {
        openMyExercisesPageAction()
    }
    func openMyAchievmentsPage() {
        openMyAchievmentsPageAction()
    }
    func openPersonalAccountPage() {
        openPersonalAccountPageAction()
    }
    func openSettingsPage() {
        openSettingsPageAction()
    }
    func openAboutAppPage() {
        openAboutAppPageAction()
    }
    func exit() {
        exitAction()
    }
    
}

//MARK: - Output

extension PersonPagePresenter {

    private func delegateSetupAvatar() {
        delegate?.setupAvatar()
    }
    private func delegateAvatarTap() {
        delegate?.avatarTap()
    }
    private func delegateSetupMenu() {
        delegate?.setupMenu()
    }
    private func delegateOpenTrainingProgramsPage() {
        delegate?.openTrainingProgramsPage()
    }
    private func delegateOpenMyWorkoutsPage() {
        delegate?.openMyWorkoutsPage()
    }
    private func delegateOpenMyExercisesPage() {
        delegate?.openMyExercisesPage()
    }
    private func delegateOpenMyAchievmentsPage() {
        delegate?.openMyAchievmentsPage()
    }
    private func delegateOpenPersonalAccountPage() {
        delegate?.openPersonalAccountPage()
    }
    private func delegateOpenSettingsPage() {
        delegate?.openSettingsPage()
    }
    private func delegateOpenAboutAppPage() {
        delegate?.openAboutAppPage()
    }
    private func delegateExit() {
        delegate?.exit()
    }
}
