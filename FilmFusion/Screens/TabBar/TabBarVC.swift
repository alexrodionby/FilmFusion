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
            generateVC(viewController: FavoritesVC(), image: Resources.Images.TabBar.favoritesOff, selectedImage: Resources.Images.TabBar.favoritesOn, tag: Tabs.favorites.rawValue),
            generateVC(viewController: SettingsVC(), image: Resources.Images.TabBar.settingsOff, selectedImage: Resources.Images.TabBar.settingsOn, tag: Tabs.search.rawValue)
        ]
    }
    
    private func generateVC(viewController: UIViewController, image: UIImage?, selectedImage: UIImage?, tag: Int) -> UINavigationController {
        
        let iconSize = CGSize(width: tabBar.bounds.height * 0.7, height: tabBar.bounds.height * 0.7)
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).resized(to: iconSize)
        viewController.tabBarItem.selectedImage = selectedImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).resized(to: iconSize)
        viewController.tabBarItem.tag = tag
        
        
//        let iconImage = UIImage(named: "icon-name")?.resized(to: iconSize)
//        tabBarItem.image = iconImage

        
        return UINavigationController(rootViewController: viewController)
    }
    
    private func setTabBarAppearance() {
        selectedIndex = 2 // Стартуем с экрана номер 3
 
//        let width = tabBar.bounds.width
//        let height = tabBar.bounds.height
//
//        tabBar.itemWidth = width / 3
//        tabBar.itemPositioning = .centered


    }
    
//    private func configureTabBar() {
//        tabBar.tintColor = Resources.Colors.tabBarActive
//        tabBar.barTintColor = Resources.Colors.tabBarInActive
//        tabBar.backgroundColor = Resources.Colors.tabBarLight // Реализовать при смене темы на другую
//
//        let searchController = UIViewController()
//        let recentController = UIViewController()
//        let homeController = UIViewController()
//        let favoritesController = UIViewController()
//        let settingsController = UIViewController()
//
//        let searchNavigation = UINavigationController(rootViewController: searchController)
//        let recentNavigation = UINavigationController(rootViewController: recentController)
//        let homeNavigation = UINavigationController(rootViewController: homeController)
//        let favoritesNavigation = UINavigationController(rootViewController: favoritesController)
//        let settingsNavigation = UINavigationController(rootViewController: settingsController)
//
//        searchController.tabBarItem = UITabBarItem(title: "", image: Resources.Images.TabBar.search, tag: Tabs.search.rawValue)
//        recentController.tabBarItem = UITabBarItem(title: "", image: Resources.Images.TabBar.recentVideo, tag: Tabs.recentVideo.rawValue)
//        homeController.tabBarItem = UITabBarItem(title: "", image: Resources.Images.TabBar.home, tag: Tabs.home.rawValue)
//        favoritesController.tabBarItem = UITabBarItem(title: "", image: Resources.Images.TabBar.favorites, tag: Tabs.favorites.rawValue)
//        settingsNavigation.tabBarItem = UITabBarItem(title: "", image: Resources.Images.TabBar.settings, tag: Tabs.settings.rawValue)
//
//        setViewControllers([searchNavigation, recentNavigation, homeNavigation, favoritesNavigation, settingsNavigation], animated: false)
//
//    }
    


}

extension UIImage {
    
    func resized(to size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
        return image
    }
    
}
