//
//  TabBarController.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 14.09.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let arrayOfPages: [TabBarMenuModel] = TabBarMenuModel.allCases
        
        var arrayOfNavigationControllers = [UINavigationController]()
        
        for menu in arrayOfPages {
            guard let navigationController = setupTabBarController(menu) else { continue }
            arrayOfNavigationControllers.append(navigationController)
        }
        
        viewControllers = arrayOfNavigationControllers
        tabBar.isTranslucent = false
        tabBar.standardAppearance.backgroundColor = .white
        tabBar.backgroundColor = .white
        tabBar.tintColor = .systemRed
    }
    
    private func setupTabBarController(_ tabBarMenu: TabBarMenuModel) -> UINavigationController? {
        
        let clearImage = UIImage(systemName: "line.3.horizontal")?.withTintColor(.clear, renderingMode: .alwaysOriginal)
    
        let appearance = UINavigationBarAppearance()
        appearance.shadowImage = clearImage
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        let navigationController = UINavigationController(rootViewController: tabBarMenu.viewController)
        navigationController.view.backgroundColor = .white
        navigationController.navigationBar.tintColor = .black
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.tabBarItem.title = tabBarMenu.title
        navigationController.tabBarItem.image = UIImage(systemName: tabBarMenu.image)
        return navigationController
    }
}
