//
//  Resources.swift
//  FilmFusion
//
//  Created by Alexandr Rodionov on 1.04.23.
//

import UIKit

enum Resources {
    
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
