//
//  TabBarVCNew.swift
//  FilmFusion
//
//  Created by Alexandr Rodionov on 3.04.23.
//

import UIKit

class TabBarVCNew: UITabBarController {
    
    enum Tabs: Int {
        case search
        case recentWatch
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
        
        viewControllers = [
            generateVC(viewController: SearchVC(), title: Resources.Strings.TabBar.search, image: Resources.Images.TabBar.searchOff, selectedImage: Resources.Images.TabBar.searchOn, tag: Tabs.search.rawValue),
            generateVC(viewController: RecentVideoVC(), title: Resources.Strings.TabBar.recentWatch, image: Resources.Images.TabBar.recentWatchOff, selectedImage: Resources.Images.TabBar.recentWatchOn, tag: Tabs.recentWatch.rawValue),
            generateVC(viewController: HomeVC(), title: Resources.Strings.TabBar.home, image: Resources.Images.TabBar.homeOff, selectedImage: Resources.Images.TabBar.homeOn, tag: Tabs.home.rawValue),
            generateVC(viewController: FavoritesVC(), title: Resources.Strings.TabBar.favorites, image: Resources.Images.TabBar.favoritesOff, selectedImage: Resources.Images.TabBar.favoritesOn, tag: Tabs.favorites.rawValue),
            generateVC(viewController: SettingsVC(), title: Resources.Strings.TabBar.settings, image: Resources.Images.TabBar.settingsOff, selectedImage: Resources.Images.TabBar.settingsOn, tag: Tabs.search.rawValue)
        ]
        
        
    }
    
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?, selectedImage: UIImage?, tag: Int) -> UINavigationController {
        viewController.tabBarItem.image = image?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        viewController.tabBarItem.selectedImage = selectedImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        viewController.tabBarItem.tag = tag
        viewController.tabBarItem.title = title
        
        return UINavigationController(rootViewController: viewController)
    }
    
    private func setTabBarAppearance() {
        selectedIndex = 2 // Стартуем с экрана номер 3
        tabBar.backgroundColor = UIColor(named: "customBackground")
        
        tabBar.itemWidth = tabBar.frame.size.width / 5
        if let centerItem = tabBar.items?[2] {
            centerItem.imageInsets = UIEdgeInsets(top: -20, left: 0, bottom: 20, right: 0)
            centerItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -10)

        }


    }
}

