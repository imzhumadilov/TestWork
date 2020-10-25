//
//  BasicTabBarController.swift
//  BeMove
//
//  Created by  Кирилл on 3/20/19.
//  Copyright © 2019 AppCraft. All rights reserved.
//

import Foundation
import UIKit

class BasicTabBarController: UIViewController {
    
    class func create(with rootControllersData: [BasicTabBarViewModel]) -> UIViewController {
        let tabVC = AZTabBarController(withTabIcons: rootControllersData.map({ $0.image ?? UIImage() }))
        
        for index in 0..<rootControllersData.count {
            tabVC.setTitle(rootControllersData[index].title, atIndex: index)
            tabVC.setViewController(rootControllersData[index].controller, atIndex: index)
        }
        
        tabVC.selectedColor = .black
        tabVC.highlightColor = .black
        tabVC.defaultColor = .lightGray
        tabVC.buttonsBackgroundColor = .white
        tabVC.selectionIndicatorHeight = 0
        tabVC.selectionIndicatorColor = .clear
        tabVC.separatorLineColor = .clear
        tabVC.tabBarHeight = 59.0
        
        return tabVC
    }
    
}

public class BasicTabBarViewModel {
    var title: String
    var image: UIImage?
    var controller: UIViewController
    
    init(title: String, controller: UIViewController, image: UIImage? = nil) {
        self.title = title
        self.image = image
        self.controller = controller
    }
}
