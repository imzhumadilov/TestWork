//
//  TabBarController.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 23.10.2020.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [createAlbumsListViewController()/*, createSavedAlbumsViewController()*/]
    }
    
    // MARK: - Module functions
    private func createAlbumsListViewController() -> UIViewController {
        
        let viewController = AlbumListAssembly.create()
        AlbumListAssembly.configure(with: viewController)
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        navigationController.tabBarItem.title = "Network"
        navigationController.tabBarItem.image = UIImage(systemName: "photo.on.rectangle.fill")
        
        return navigationController
    }
    
//    private func createSavedAlbumsViewController() -> UIViewController {
//
//        let viewController = SavedAlbumsConfigurator.create()
//        SavedAlbumsConfigurator.configure(with: viewController)
//        
//        let navigationController = UINavigationController(rootViewController: viewController)
//        let attributes = [NSAttributedString.Key.font: UIFont(name: "Noteworthy-Bold", size: 16)]
//        UINavigationBar.appearance().titleTextAttributes = attributes as [NSAttributedString.Key: Any]
//        
//        navigationController.tabBarItem.title = "Database"
//        navigationController.tabBarItem.image = UIImage(systemName: "photo.on.rectangle.fill")
//        
//        return navigationController
//    }
}
