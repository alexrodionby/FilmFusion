//
//  TabBarVCNew.swift
//  FilmFusion
//
//  Created by Alexandr Rodionov on 3.04.23.
//

import UIKit

@available(iOS 15.0, *)
class TabBarVC: UITabBarController {
    
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
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(viewController: SearchVC(), title: Resources.Strings.TabBar.search, image: Resources.Images.TabBar.searchOff, selectedImage: Resources.Images.TabBar.searchOn, tag: Tabs.search.rawValue),
            generateVC(viewController: RecentVideoVC(), title: Resources.Strings.TabBar.recentWatch, image: Resources.Images.TabBar.recentWatchOff, selectedImage: Resources.Images.TabBar.recentWatchOn, tag: Tabs.recentWatch.rawValue),
            generateVC(viewController: HomeVC(), title: Resources.Strings.TabBar.home, image: Resources.Images.TabBar.homeOff, selectedImage: Resources.Images.TabBar.homeOn, tag: Tabs.home.rawValue),
            generateVC(viewController: FavoritesViewController(), title: Resources.Strings.TabBar.favorites, image: Resources.Images.TabBar.favoritesOff, selectedImage: Resources.Images.TabBar.favoritesOn, tag: Tabs.favorites.rawValue),
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
        tabBar.tintColor = UIColor(named: "customTabBarIconSelectedTint")
        
        // устанавливаем ширину и высоту центральной ячейки таб-бара
        let tabBarItemSize = CGSize(width: tabBar.frame.width / 5, height: tabBar.frame.height * 0.7)
        let centerItem = tabBar.items?[2]
        centerItem?.title = ""
        centerItem?.selectedImage = centerItem?.selectedImage?.resize(to: CGSize(width: tabBarItemSize.width * 0.55, height: tabBarItemSize.height * 1.2)).withRenderingMode(.alwaysOriginal)
        centerItem?.image = centerItem?.selectedImage?.resize(to: CGSize(width: tabBarItemSize.width * 0.55, height: tabBarItemSize.height * 1.2)).withRenderingMode(.alwaysOriginal)
        
        // устанавливаем отступы между ячейками таб-бара
        tabBar.itemSpacing = (tabBar.frame.width - tabBarItemSize.width) / 8
        
        if let tabBarItems = tabBar.items {
            // Выравниваем элементы таб-бара по горизонтали на одной линии, в зависимости от смещения центральной ячейки
            for (index, tabBarItem) in tabBarItems.enumerated() {
                if index < 2 {
                    // элементы слева от центральной ячейки
                    tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: (tabBarItemSize.width - tabBarItem.image!.size.width) / 2, bottom: 0, right: 0)
                } else if index > 2 {
                    // элементы справа от центральной ячейки
                    tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (tabBarItemSize.width - tabBarItem.image!.size.width) / 2)
                } else {
                    // центральная ячейка
                    tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                }
            }
        }
    }
}

