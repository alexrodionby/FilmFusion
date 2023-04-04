//
//  Resources.swift
//  FilmFusion
//
//  Created by Alexandr Rodionov on 1.04.23.
//

import UIKit

enum Resources {
    
    enum Colors {
        static var tabBarActive = UIColor(hexString: "#504EB6")
        static var tabBarInActive = UIColor(hexString: "#BFC5CC")
        static var tabBarDark = UIColor(hexString: "#171725")
        static var tabBarLight = UIColor(hexString: "#FFFFFF")
    }
    
    enum Strings {
        enum TabBar {
            static var search = "Search"
            static var recentWatch = "Recent Watch"
            static var home = "Home"
            static var favorites = "Favorites"
            static var settings = "Settings"
        }
    }
    
    enum Images {
        enum TabBar {
//            static var searchOn = UIImage(named: "searchOn")
//            static var recentVideoOn = UIImage(named: "recentVideoOn")
//            static var home = UIImage(named: "home")
//            static var favoritesOn = UIImage(named: "favoritesOn")
//            static var settingsOn = UIImage(named: "settingsOn")
//
//            static var searchOff = UIImage(named: "searchOff")
//            static var recentVideoOff = UIImage(named: "recentVideoOff")
//            static var favoritesOff = UIImage(named: "favoritesOff")
//            static var settingsOff = UIImage(named: "settingsOff")
            
            
            static var searchOn = UIImage(systemName: "magnifyingglass.circle.fill")?.withTintColor(UIColor(named: "customTabBarIconSelectedTint")!)
            static var recentWatchOn = UIImage(systemName: "play.circle.fill")?.withTintColor(UIColor(named: "customTabBarIconSelectedTint")!)
            static var homeOn = UIImage(systemName: "house.circle.fill")?.withTintColor(UIColor(named: "customTabBarIconSelectedTint")!)
            static var favoritesOn = UIImage(systemName: "heart.circle.fill")?.withTintColor(UIColor(named: "customTabBarIconSelectedTint")!)
            static var settingsOn = UIImage(systemName: "person.circle.fill")?.withTintColor(UIColor(named: "customTabBarIconSelectedTint")!)
            
            static var searchOff = UIImage(systemName: "magnifyingglass.circle")?.withTintColor(UIColor(named: "customTabBarIconUnSelectedTint")!)
            static var recentWatchOff = UIImage(systemName: "play.circle")?.withTintColor(UIColor(named: "customTabBarIconUnSelectedTint")!)
            static var homeOff = UIImage(systemName: "house.circle")?.withTintColor(UIColor(named: "customTabBarIconUnSelectedTint")!)
            static var favoritesOff = UIImage(systemName: "heart.circle")?.withTintColor(UIColor(named: "customTabBarIconUnSelectedTint")!)
            static var settingsOff = UIImage(systemName: "person.circle")?.withTintColor(UIColor(named: "customTabBarIconUnSelectedTint")!)
        }
    }
    
}

