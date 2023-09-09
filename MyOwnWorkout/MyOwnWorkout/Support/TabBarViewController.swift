//
//  TabBarViewController.swift
//  MyOwnWorkout
//
//  Created by Алмаз Рахматуллин on 09.09.2023.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let array: [Menu] = [.main, .schedule, .feed]
        let array: [Menu] = Menu.allCases
        
        var newArray = [UINavigationController]()
        
        for menu in array {
            guard let nav = setup(menu) else { continue }
            newArray.append(nav)
        }
        
        viewControllers = newArray
        tabBar.isTranslucent = false
        tabBar.standardAppearance.backgroundColor = .white
        tabBar.backgroundColor = .white
        tabBar.tintColor = .blue
    }
    
    
    private func setup(_ menu: Menu) -> UINavigationController? {
        
        let lineImage = UIImage(systemName: "pencil")?.withTintColor(.clear, renderingMode: .alwaysOriginal)
        
        let appearance = UINavigationBarAppearance()
        appearance.shadowImage = lineImage
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        let navigationController = UINavigationController(rootViewController: menu.viewController)
        navigationController.view.backgroundColor = .white
        navigationController.navigationBar.tintColor = UIColor.black
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.tabBarItem.title = menu.title
        navigationController.tabBarItem.image = UIImage(systemName: menu.image)
        
        return navigationController
    }
}

