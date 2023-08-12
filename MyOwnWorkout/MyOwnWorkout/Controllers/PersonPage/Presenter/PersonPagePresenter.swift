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
