//
//  TabBarVC.swift
//  FilmFusion
//
//  Created by Alexandr Rodionov on 1.04.23.
//

import UIKit

final class TabBarVC: UITabBarController {
    
    enum Tabs: Int {
        case search
        case recentVideo
        case home
        case favorites
        case settings
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppearance()
    }
    
    private func generateTabBar() {
        
        tabBar.tintColor = Resources.Colors.tabBarActive
        tabBar.barTintColor = Resources.Colors.tabBarInActive
        tabBar.backgroundColor = Resources.Colors.tabBarLight // Реализовать при смене темы на другую
        
        viewControllers = [
            generateVC(viewController: SearchVC(), image: Resources.Images.TabBar.searchOff, selectedImage: Resources.Images.TabBar.searchOn, tag: Tabs.search.rawValue),
            generateVC(viewController: RecentVideoVC(), image: Resources.Images.TabBar.recentVideoOff, selectedImage: Resources.Images.TabBar.recentVideoOn, tag: Tabs.recentVideo.rawValue),
            generateVC(viewController: HomeVC(), image: Resources.Images.TabBar.home, selectedImage: Resources.Images.TabBar.home, tag: Tabs.home.rawValue),
            generateVC(viewController: FavoritesViewController(), image: Resources.Images.TabBar.favoritesOff, selectedImage: Resources.Images.TabBar.favoritesOn, tag: Tabs.favorites.rawValue),
            generateVC(viewController: SettingsVC(), image: Resources.Images.TabBar.settingsOff, selectedImage: Resources.Images.TabBar.settingsOn, tag: Tabs.search.rawValue)
        ]
    }
    
    private func generateVC(viewController: UIViewController, image: UIImage?, selectedImage: UIImage?, tag: Int) -> UINavigationController {
        
        let iconSize = CGSize(width: tabBar.bounds.height * 0.7, height: tabBar.bounds.height * 0.7)
        viewController.tabBarItem.image = image?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).resized(to: iconSize)
        viewController.tabBarItem.selectedImage = selectedImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).resized(to: iconSize)
        viewController.tabBarItem.tag = tag
        return UINavigationController(rootViewController: viewController)
    }
    
    private func setTabBarAppearance() {
        selectedIndex = 2 // Стартуем с экрана номер 3
    }
    
}
