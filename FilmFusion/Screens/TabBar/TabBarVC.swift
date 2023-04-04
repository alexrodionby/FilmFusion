//
//  TabBarVC.swift
//  FilmFusion
//
//  Created by Alexandr Rodionov on 1.04.23.
//

import UIKit

//final class TabBarVC: UITabBarController {
//
//    enum Tabs: Int {
//        case search
//        case recentVideo
//        case home
//        case favorites
//        case settings
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        generateTabBar()
//        setTabBarAppearance()
//    }
//
//    private func generateTabBar() {
//
//        tabBar.tintColor = Resources.Colors.tabBarActive
//        tabBar.barTintColor = Resources.Colors.tabBarInActive
//        tabBar.backgroundColor = Resources.Colors.tabBarLight // Реализовать при смене темы на другую
//
//        viewControllers = [
//            generateVC(viewController: SearchVC(), image: Resources.Images.TabBar.searchOff, selectedImage: Resources.Images.TabBar.searchOn, tag: Tabs.search.rawValue),
//            generateVC(viewController: RecentVideoVC(), image: Resources.Images.TabBar.recentVideoOff, selectedImage: Resources.Images.TabBar.recentVideoOn, tag: Tabs.recentVideo.rawValue),
//            generateVC(viewController: HomeVC(), image: Resources.Images.TabBar.home, selectedImage: Resources.Images.TabBar.home, tag: Tabs.home.rawValue),
//            generateVC(viewController: FavoritesVC(), image: Resources.Images.TabBar.favoritesOff, selectedImage: Resources.Images.TabBar.favoritesOn, tag: Tabs.favorites.rawValue),
//            generateVC(viewController: SettingsVC(), image: Resources.Images.TabBar.settingsOff, selectedImage: Resources.Images.TabBar.settingsOn, tag: Tabs.search.rawValue)
//        ]
//    }
//
//    private func generateVC(viewController: UIViewController, image: UIImage?, selectedImage: UIImage?, tag: Int) -> UINavigationController {
//
//        let iconSize = CGSize(width: tabBar.bounds.height * 0.7, height: tabBar.bounds.height * 0.7)
//        viewController.tabBarItem.image = image?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).resized(to: iconSize)
//        viewController.tabBarItem.selectedImage = selectedImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).resized(to: iconSize)
//        viewController.tabBarItem.tag = tag
//        return UINavigationController(rootViewController: viewController)
//    }
//
//    private func setTabBarAppearance() {
//        selectedIndex = 2 // Стартуем с экрана номер 3
//    }
//
//}
//
////extension TabBarVC: UITabBarControllerDelegate {
////
////    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
////        guard let fromView = selectedViewController?.view, let toView = viewController.view, let fromIndex = selectedViewController?.tabBarItem.tag, let toIndex = tabBar.items?.firstIndex(of: viewController.tabBarItem) else {
////            return false
////        }
////
////        if fromIndex == toIndex {
////            return false
////        }
////
////        let tabViewControllers = tabBarController.viewControllers ?? []
////        let isIncreasing = toIndex > fromIndex
////        let increaseCoefficient: CGFloat = isIncreasing ? 1.2 : 0.8
////        let decreaseCoefficient: CGFloat = isIncreasing ? 0.8 : 1.2
////
////        let screenWidth = UIScreen.main.bounds.width
////        let width = screenWidth / CGFloat(tabViewControllers.count)
////
////        let initialFrame = CGRect(x: CGFloat(fromIndex) * width, y: 0, width: width, height: tabBar.frame.height)
////        let finalFrame = CGRect(x: CGFloat(toIndex) * width, y: 0, width: width, height: tabBar.frame.height)
////
////        let fromViewSnapshot = fromView.snapshotView(afterScreenUpdates: false)
////        fromViewSnapshot?.frame = initialFrame
////        tabBar.addSubview(fromViewSnapshot!)
////
////        let toViewSnapshot = toView.snapshotView(afterScreenUpdates: true)
////        toViewSnapshot?.frame = finalFrame
////        tabBar.addSubview(toViewSnapshot!)
////
////        selectedViewController = viewController
////        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
////            fromViewSnapshot?.frame = initialFrame.applying(CGAffineTransform(scaleX: decreaseCoefficient, y: decreaseCoefficient))
////            toViewSnapshot?.frame = finalFrame.applying(CGAffineTransform(scaleX: increaseCoefficient, y: increaseCoefficient))
////        }, completion: { _ in
////            fromViewSnapshot?.removeFromSuperview()
////            toViewSnapshot?.removeFromSuperview()
////        })
////
////        return true
////    }
////
////}
