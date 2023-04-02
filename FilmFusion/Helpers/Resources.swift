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
    
    enum Images {
        enum TabBar {
            static var searchOn = UIImage(named: "searchOn")
            static var recentVideoOn = UIImage(named: "recentVideoOn")
            static var home = UIImage(named: "home")
            static var favoritesOn = UIImage(named: "favoritesOn")
            static var settingsOn = UIImage(named: "settingsOn")
            
            static var searchOff = UIImage(named: "searchOff")
            static var recentVideoOff = UIImage(named: "recentVideoOff")
            static var favoritesOff = UIImage(named: "favoritesOff")
            static var settingsOff = UIImage(named: "settingsOff")
        }
    }
    
}

